//
//  AuthService.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 12/10/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias userData = (_ error: String?, _ authDataResult: AuthDataResult?) -> Void

class AuthService {

    private static let _sharedInstance = AuthService()
    
    static var sharedInstance : AuthService {
        return _sharedInstance
    }
    
    func loginWith(email: String, password: String, onComplete: userData?) {
    
        Auth.auth().signIn(withEmail: email, password: password, completion: { (authDataResult: AuthDataResult?, error: Error?) in
            guard let authDataResult = authDataResult else {
                onComplete?("Login Error", nil)
                return
            }//Error Handling here
            print("signed in successfully \(authDataResult)")
            User.sharedIntances.setupUserInfo(uid: authDataResult.user.uid, firstName: "", lastName: "", email: email)
            onComplete?(nil, authDataResult)
        })
    }

    func createAccountWith(email: String, password: String, onComplete: userData?) {
    
        // Call firebase create user API.  Will return us a user or error.
        Auth.auth().createUser(withEmail: email, password: password, completion: { (authDataResult: AuthDataResult?, error: Error?) in
            // Nil check if there is a unique ID for user
            guard let _ = authDataResult else { return }
            // We have a user here so lets sign them in via sign in API
            self.loginWith(email: email, password: password, onComplete: { (error: String?, authDataResult: AuthDataResult?) in
                onComplete?(nil, authDataResult)
            })

        })
        
    }
    
}
