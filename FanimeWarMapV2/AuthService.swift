//
//  AuthService.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 12/10/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ error: String?, _ user: AnyObject?) -> Void

class AuthService {

    private static let _sharedInstance = AuthService()
    
    static var sharedInstance : AuthService {
        return _sharedInstance
    }
    
    func loginWith(email: String, password: String, onComplete: Completion?) {
    
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            guard let user = user else {
                onComplete?("Login Error", nil)
                return
            }//Error Handling here
            print("signed in successfully \(user)")
            User.sharedIntances.setupUserInfo(uid: user.uid, firstName: "", lastName: "", email: email)
            onComplete?(nil, user)
        })
    }

    func createAccountWith(email: String, password: String, onComplete: Completion?) {
    
        // Call firebase create user API.  Will return us a user or error.
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            // Nil check if there is a unique ID for user
            guard let _ = user?.uid else { return }
            // We have a user here so lets sign them in via sign in API
            self.loginWith(email: email, password: password, onComplete: { (error: String?, user: AnyObject?) in
                onComplete?(nil, user)
            })

        })
        
    }
    
}
