//
//  AuthService.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/5/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import Firebase

class AuthService
{
    static let instance = AuthService() //A static instance gives us access to the value for the entire life cycle of the app, it's important not to abuse it.
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ())
    {
        Auth.auth().createUser(withEmail: email, password: password)
        { (user, error) in
            guard let user = user //If a user is returned then we are going to create a constant that will hold the information for the user. If there is not a user returned then there is an error, and we will return the error.
                else
                {
                    userCreationComplete(false, error)
                    return //Get out of function if we don't get a user.
                }
            
            let userData = ["provider": user.providerID, "email": user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ())
    {
        Auth.auth().signIn(withEmail: email, password: password)
        { (user, error) in
            guard let user = user
                else
                {
                    loginComplete(false, error)
                    return
                }
            loginComplete(true, error) //The user will be logged in.
        }
    }
    
}


