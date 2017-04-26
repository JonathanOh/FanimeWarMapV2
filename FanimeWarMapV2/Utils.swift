//
//  Utils.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 12/1/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation
import UIKit

class Utils {

    static func getArrayOfMenuOptions() -> [Menu] {
        return [.MapPicker, .AddARover, .DeployTeam, .ViewTeams, .SaveMap, .MoveTeamsMode, .RemoveTeamsMode, .LogOut]
    }
    
    static func getDeployableTeams(teams: [Team]) -> [Team] {
        var deployableTeams : [Team] = []
        for team in teams {
            if !team.isTeamDeployed {
                deployableTeams.append(team)
            }
        }
        return deployableTeams
    }
    
    static func getDeployedTeams(teams: [Team]) -> [Team] {
        var deployedTeams : [Team] = []
        for team in teams {
            if team.isTeamDeployed {
                deployedTeams.append(team)
            }
        }
        return deployedTeams
    }
    
    static func getTeamsForGivenMap(teams: [Team], map: Map) -> [Team] {
        var teamsOnMap : [Team] = []
        for team in teams {
            if team.isTeamDeployed && team.assignedOnMap == map {
                teamsOnMap.append(team)
            }
        }
        return teamsOnMap
    }
    
    static func layoutTeamsInImageView(teams: [Team], imageView: UIImageView) {
        for team in teams {
            guard let iconView = team.teamIconView else { return }
            imageView.addSubview(iconView)
        }
    }
    
    static func getCurrentArrayOfTeams() -> [Team] {
        var teamHolder : [Team] = []
        
        for pokemon in Pokemon {
            let team = Team(name: pokemon, icon: pokemon)
            teamHolder.append(team)
        }
        return teamHolder
    }
    
    static func removeTeamIconsFromMap(teams: [Team], map: Map) {
        for team in teams {
            if team.assignedOnMap == map {
                team.teamIconView?.removeFromSuperview()
            }
        }
    }
    
    static func convertTeamToDictionary(team: Team) -> [String : Any] {
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
        return teamDictionary
    }
    
    static func numberOfTeamsOnMap(teams: [Team]) -> [String : Int] {
        var tempDictionary = [String : Int]()
        for team in teams {
            guard let map = team.assignedOnMap else { continue }
            if let _ = tempDictionary[map.rawValue] {
                tempDictionary[map.rawValue]! += 1
            } else {
                tempDictionary[map.rawValue] = 1
            }
        }
        return tempDictionary
    }
    
    static func getMapEnumFromString(name: String) -> Map? {
        if name == "Whole Map" { return Map.WholeMap }
        else if name == "Upper Level Map" { return Map.UpperLevelMap }
        else if name == "Lower Level Map" { return Map.LowerLevelMap }
        else { return nil }
    }
    
    static func closestTeamToTouchEvent(touchPoint: CGPoint, arrayOfTeams: [Team]) -> Team? {
        var closestTeamToTouch : Team?
        var closestDistanceValue : CGFloat = -1.0 // Use a default place holder value of -1
        
        for team in arrayOfTeams {
            guard let teamIconView = team.teamIconView else {
                break
            }
            let xDistance = abs(teamIconView.center.x - touchPoint.x)
            let yDistance = abs(teamIconView.center.y - touchPoint.y)
            let currentDistanceValue : CGFloat = xDistance + yDistance
            if closestDistanceValue == -1 {
                closestDistanceValue = currentDistanceValue
                closestTeamToTouch = team
            } else if (currentDistanceValue < closestDistanceValue) {
                closestDistanceValue = currentDistanceValue
                closestTeamToTouch = team
            }
        }
        let fingerIsCloseEnoughToImageToMoveImage = closestDistanceValue > 60
        if fingerIsCloseEnoughToImageToMoveImage {
            closestTeamToTouch = nil
        }
        return closestTeamToTouch
    }
    static func mapWasSavedAlert() -> UIAlertController {
        let tempAlert = UIAlertController(title: "Yay!", message: "Team positions were saved!", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        tempAlert.addAction(okAction)
        return tempAlert
    }
    static func placeHolderAlert() -> UIAlertController {
        let tempAlert = UIAlertController(title: "Whoops!", message: "This is currently in development", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        tempAlert.addAction(okAction)
        return tempAlert
    }
    static func customWhoopsAlert(message: String) -> UIAlertController {
        let tempAlert = UIAlertController(title: "Oops!", message: "\(message)", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        tempAlert.addAction(okAction)
        return tempAlert
    }
    static func removeTeamAlert(team: Team) -> UIAlertController {
        let tempAlert = UIAlertController(title: "Alert", message: "Remove \(team.teamName) from map?", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in
            team.teamWasUndeployed()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        tempAlert.addAction(okAction)
        tempAlert.addAction(cancelAction)
        return tempAlert
    }
}
