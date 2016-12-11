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
    
    func loginWith(email: String, password: String) {
    
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            guard let user = user else { return }//Error Handling here
        })
    }

    func createAccountWith(email: String, password: String, onComplete: Completion?) {
    
        // Call firebase create user API.  Will return us a user or error.
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            // Nil check if there is a unique ID for user
            guard let _ = user?.uid else { return }
            // We have a user here so lets sign them in via sign in API
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                guard let user = user else { return }
                //we have a user that is now logged in here
                onComplete?(nil, user)  // Since we guarantee a user here, we pass user data back to whoever called this function
            })
        })
        
    }
    
}
