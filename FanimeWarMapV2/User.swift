//
//  User.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 12/11/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation

class User {
    
    private static let _sharedInstance = User()
    
    static var sharedIntances: User {
        return _sharedInstance
    }
    
    private var _uid : String?
    private var _firstName : String?
    private var _lastName : String?
    private var _email : String?
    
    var uid: String? { return _uid }
    var firstName: String? { return _firstName }
    var lastName: String? { return _lastName }
    var email: String? { return _email }
    
    func setupUserInfo(uid: String, firstName: String, lastName: String, email: String) {
        _uid = uid
        _firstName = firstName
        _lastName = lastName
        _email = email
    }
    
}
