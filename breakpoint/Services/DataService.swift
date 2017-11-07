//
//  DataService.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/5/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import Firebase

let DB_BASE = Database.database().reference() //Allows us to access the base URL of our Firebasedatabse. We put the constant outside of the class DataService so that it will be available inside of the function.


class DataService
{
    static let instance = DataService() //Creatign an instance of this class inside itself so it's available around the app.
    
    //Private so only this file can use it. This helps us be a safe coder by preventing the values from being overwritten outside the file.
    private var _REF_BASE = DB_BASE //Our root url
    private var _REF_USERS = DB_BASE.child("users") //We are going to append a child to DB_BASE
    private var _REF_GROUPS = DB_BASE.child("groups") //Append groups Key to root url
    private var _REF_FEED = DB_BASE.child("feed") //Append feed Key to root url
    
    var REF_BASE: DatabaseReference //Now we are creating public variables that access the private variables above so we can set the value and use the information. If we need to set a value to REF_USERS it will give us the value that we set that way the initial valus are not overwritten.
    {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference
    {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference
    {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference
    {
        return _REF_FEED
    }
    
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) //Creates a new firebase user.
    {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) //Convert UID into a username. the handler allows us to let the value of username escape out of this function.
    {
        REF_USERS.observeSingleEvent(of: .value, with:
            { (userSnapshot) in
                guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return } //If we get nothing back then return nothing so the app does not crash.
                for user in userSnapshot
                {
                    if user.key == uid
                    {
                        handler(user.childSnapshot(forPath: "email").value as! String) //Get the email of the passed in user's UID
                    }
                }
                
            })
        //Observe the users reference and find the one that matches our current user.
    }
    
    //Send the feed to firebase.
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ())
    {
        if groupKey != nil
        {
            //Send to groups REF
        }
        else //Pass message into feed
        {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid]) //This will generate a unique identifier for every message that comes in. That's what we want because we don't need to give it a specific name because the specific uid of the message doesn't matter, but inside we are going to keep the uid of the user who wrote the message.
            sendComplete(true)
        }
    }
    
    
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) //We are going to pull datat from feed reference and pass data out of our closure.
    {
        
        var messageArray = [Message]() //We are going to add the messages from below to our messageArray
        
        //Download every message from the Feed Array
        REF_FEED.observeSingleEvent(of: .value, with:
            { (feedMessageSnapshot) in
                guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return } //Return all of the messages else if there are no messages, return and get out of the function.
                
                for message in feedMessageSnapshot
                {
                    let content = message.childSnapshot(forPath: "content").value as! String //We pull the content from the specific message dataSnapshot.
                    let senderID = message.childSnapshot(forPath: "senderId").value as! String //We pull the userID from the specific message dataSnapshot.
                    
                    let message = Message(content: content, senderId: senderID) //Create a message using the data above.
                    messageArray.append(message) //Append the message to the message array
                }
                
                handler(messageArray) //Download all of our messages and append them into the messageArray and return the messageArray.
            })
    }
    
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) //Get an array of all the users from firebase except the current user.
    {
        var emailArray = [String]()
        REF_USERS.observe(.value, with:
            { (userSnapshot) in
                guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
                for user in userSnapshot
                {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    if email.contains(query) == true && email != Auth.auth().currentUser?.email
                    {
                        emailArray.append(email)
                    }
                }
                handler(emailArray)
            })
    }
    
    func getIDs(forUsernames usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) //get the UIDs for all the users we pass in.
    {
        REF_USERS.observeSingleEvent(of: .value, with:
            { (userSnapshot) in
                var idArray = [String]() //A empty array that we will add values to and then pass back to the handler.
                guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
                for user in userSnapshot
                {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    if usernames.contains(email) //check to see if a usernames array contains a certain email.
                    {
                        idArray.append(user.key) //add the user's key to the idArray
                    }
                }
                handler(idArray) //return the idArray
            })
    }
    
    func createGroup(withTitle title: String, andDescription description: String, forUserUIDs ids: [String], handler: @escaping (_ groupCreated: Bool) -> ())
    {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
        handler(true)
    }
    
    func getAllGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) //Download all of the groups from our app.
    {
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value, with:
            { (groupSnapshot) in
                guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
                for group in groupSnapshot
                {
                   let memberArray = group.childSnapshot(forPath: "members").value as! [String] //Pull down the array of memebers and the information from it
                    if memberArray.contains((Auth.auth().currentUser?.uid)!) //If we are in the group.
                    {
                        let title = group.childSnapshot(forPath: "title").value as! String
                        let description = group.childSnapshot(forPath: "description").value as! String
                        
                        let group = Group(title: title, description: description, groupKey: group.key, groupMembers: memberArray, memberCount: memberArray.count)
                        groupsArray.append(group)
                    }
                }
                handler(groupsArray)
            })
    }
    
}
