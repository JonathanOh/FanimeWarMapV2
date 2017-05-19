//
//  DataService.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 12/11/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import UIKit

typealias teamData = (_ teams: [Team]) -> Void
typealias teamSaved = (_ success: Bool) -> Void

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
                if let teamLabel = value["label"] as? String {
                    team.updateTeamLabel(name: teamLabel)
                }
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
    func saveTeamLocations(teams: [Team], success: teamSaved?) {
        
        var imageOne: UIImage = UIImage(named: Map.WholeMap.rawValue)!
        var imageTwo: UIImage = UIImage(named: Map.UpperLevelMap.rawValue)!
        var imageThree: UIImage = UIImage(named: Map.LowerLevelMap.rawValue)!

        for team in teams {
            guard let teamImage = team.teamIcon else { continue }
            guard let teamLocation = team.teamLocation else { continue }
            guard let teamMap = team.assignedOnMap else { continue }
            let modifiedPoint: CGPoint = CGPoint(x: (teamLocation.x-15) * 2.05, y: (teamLocation.y-135) * 2.05)
            if teamMap == .WholeMap {
                imageOne = imageOne.image(byDrawingImage: teamImage, inRect: CGRect(origin: modifiedPoint, size: CGSize(width: 75, height: 75)))
            }
            if teamMap == .UpperLevelMap {
                imageTwo = imageTwo.image(byDrawingImage: teamImage, inRect: CGRect(origin: modifiedPoint, size: CGSize(width: 75, height: 75)))
            }
            if teamMap == .LowerLevelMap {
                imageThree = imageThree.image(byDrawingImage: teamImage, inRect: CGRect(origin: modifiedPoint, size: CGSize(width: 75, height: 75)))
            }
        }

        let storage = FIRStorage.storage()
        let storageRef = storage.reference()
            
        let imageDataOne: Data = UIImagePNGRepresentation(imageOne)!
        let imageOneRef = storageRef.child("Map1.jpg")
        imageOneRef.put(imageDataOne, metadata: nil) { (metaData: FIRStorageMetadata?, error: Error?) in
            print(metaData ?? 0)
            print(error ?? 0)
        }
        let imageDataTwo: Data = UIImagePNGRepresentation(imageTwo)!
        let imageTwoRef = storageRef.child("Map2.jpg")
        imageTwoRef.put(imageDataTwo, metadata: nil) { (metaData: FIRStorageMetadata?, error: Error?) in
            print(metaData ?? 0)
            print(error ?? 0)
        }
        let imageDataThree: Data = UIImagePNGRepresentation(imageThree)!
        let imageThreeRef = storageRef.child("Map3.jpg")
        imageThreeRef.put(imageDataThree, metadata: nil) { (metaData: FIRStorageMetadata?, error: Error?) in
            print(metaData ?? 0)
            print(error ?? 0)
        }
        
        let teamDictionaryReferece = mainReference.child("Teams").child("Rovers")
        var dictionaryOfUpdatedTeams = [String : Any]()
        for team in teams {
            let teamDictionary = Utils.convertTeamToDictionary(team: team)
            dictionaryOfUpdatedTeams[team.teamName] = teamDictionary
        }
        teamDictionaryReferece.updateChildValues(dictionaryOfUpdatedTeams, withCompletionBlock: { (error, databaseRef: FIRDatabaseReference) in
            if (error != nil) {
                success?(false)
            } else {
                success?(true)
            }
        })
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
            guard let userAccessLevel = profile["admin"] as? Int else { return }
            User.sharedIntances.setUsersAccess(level: userAccessLevel)
        }
    }
    
}
