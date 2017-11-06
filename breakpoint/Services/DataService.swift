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
    
}
