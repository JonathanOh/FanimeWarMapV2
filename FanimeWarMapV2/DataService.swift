//
//  DataService.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 12/11/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation
import FirebaseDatabase

typealias teamData = (_ teams: [Team]) -> Void

class DataService {

    private static let _sharedInstance = DataService()
    
    static var sharedIntances: DataService {
        return _sharedInstance
    }
    
    var mainReference: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    func getPossibleTeams(onComplete: teamData?) {
        let teamDictionaryReference = mainReference.child("Teams").child("Rovers")
        teamDictionaryReference.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) -> Void in
            var possibleTeams = [Team]()
            guard let teams = snapshot.value as? Dictionary<String, AnyObject> else { return }
            for (_, value) in teams {
                guard let name = value["name"] as? String else { continue }
                let team = Team(name: name, icon: name)
                possibleTeams.append(team)
                guard let xLocation = value["xLoc"] as? Int else { continue }
                guard let yLocation = value["yLoc"] as? Int else { continue }
                guard let map = value["map"] as? String else { continue }
                guard let mapImage = Utils.getMapEnumFromString(name: map) else { continue }
                team.setupLocationAndMap(map: mapImage, xLocation: xLocation, yLocation: yLocation)
            }
            onComplete?(possibleTeams)
        }
    }
    
    func setupFirebaseWithDummyData() {
        let teamDictionaryReference = mainReference.child("Teams").child("Rovers")
        for team in DummyResponse {
            guard let teamName = team["name"] as? String else { continue }
            teamDictionaryReference.updateChildValues([teamName : team])
        }
    }
    func saveTeamLocations(teams: [Team]) {
        let teamDictionaryReferece = mainReference.child("Teams").child("Rovers")
        //teamDictionaryReferece.by
        for team in teams {
            var teamDictionary = [String: Any]()
            teamDictionary["name"] = team.teamName
            
            if let xLocation = team.teamLocation?.x {
                teamDictionary["xLoc"] = Double(xLocation)
            }
            if let yLocation = team.teamLocation?.y {
                teamDictionary["yLoc"] = Double(yLocation)
            }
            if let mapName = team.assignedOnMap {
                teamDictionary["map"] = mapName.rawValue
            }
            teamDictionaryReferece.updateChildValues([team.teamName : teamDictionary])
        }
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
    }
    
}
