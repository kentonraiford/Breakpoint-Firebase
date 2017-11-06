//
//  Message.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/6/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//



class Message // Our message class needs content and a way to identify the senderID
{
    
    //We are going to use data encapsulation. We create private variables that will only be accessible in this file.
    private var _content: String
    private var _senderID: String
    
    //These public variables will display the information set inside the private variables and make them accessible in other files.
    var content: String
    {
        return _content
    }
    
    var senderId: String
    {
        return _senderID
    }
    
    //Give us the ability to set the value of the private variables in our file.
    init(content: String, senderId: String)
    {
        self._content = content
        self._senderID = senderId
    }
    
}
