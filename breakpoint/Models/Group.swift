//
//  Group.swift
//  breakpoint
//
//  Created by Kenton D. Raiford on 11/7/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import Firebase

class Group
{
    private var _groupTitle: String
    private var _groupDescription: String
    private var _groupKey: String //UID
    private var _memberCount: Int
    private var _groupMembers: [String] //An array of all the names of our members.
    
    
    var groupTitle: String
    {
        return _groupTitle
    }
    
    var groupDescription: String
    {
        return _groupDescription
    }
    
    var groupKey: String
    {
        return _groupKey
    }
    
    var memberCount: Int
    {
        return _memberCount
    }
    
    var groupMembers: [String]
    {
        return _groupMembers
    }
    
    init(title: String, description: String, groupKey: String, groupMembers: [String], memberCount: Int)
    {
        self._groupTitle = title
        self._groupDescription = description
        self._groupKey = groupKey
        self._groupMembers = groupMembers
        self._memberCount = memberCount
    }
    
    
    
}
