//
//  DataService.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 12/11/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataService {

    private static let _sharedInstance = DataService()
    
    static var sharedIntancs: DataService {
        return _sharedInstance
    }
    
    var mainReference: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    func saveUser(uid: String, email: String) {
        let profile: Dictionary<String, AnyObject> = ["admin" : Admin.Regular.rawValue as AnyObject, "email" : email as AnyObject, "firstName" : "Jonathan" as AnyObject, "lastName" : "Oh" as AnyObject, "loggedInCount" : 1 as AnyObject]
        mainReference.child("users").child(uid).child("profile").setValue(profile)
    }
    
    func userLoggedIn(uid: String) {
        let loggedInReference = mainReference.child("users").child(uid).child("profile")
        loggedInReference.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) -> Void in
            guard let profile = snapshot.value as? Dictionary<String, AnyObject> else { return }
            guard let loggedInCount = profile["loggedInCount"] as? Int else { return }
            let newLoggedInCount = loggedInCount + 1
            loggedInReference.updateChildValues(["loggedInCount" : newLoggedInCount])
        }
        //let newValue = loggedInReference + 1
    }

}
