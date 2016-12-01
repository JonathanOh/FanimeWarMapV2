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

    static func getArrayOfMainMenuOptions() -> [String] {
        return [MainMenu.mapPicker, MainMenu.addARover, MainMenu.deployTeam, MainMenu.viewTeams, MainMenu.saveMap, MainMenu.moveTeamsMode, MainMenu.removeTeamsMode, MainMenu.logOut]
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
    
    static func getCurrentArrayOfTeams() -> [Team] {
        var teamHolder : [Team] = []
        
        for pokemon in Pokemon {
            let team = Team(name: pokemon, icon: pokemon)
            teamHolder.append(team)
        }
        return teamHolder
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
    
    static func placeHolderAlert() -> UIAlertController {
        let tempAlert = UIAlertController(title: "Whoops!", message: "This is currently in development", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        tempAlert.addAction(okAction)
        return tempAlert
    }
    static func currentlyInMoveTeamsMode() -> UIAlertController {
        let tempAlert = UIAlertController(title: "Whoops!", message: "You are currently in Move Teams Mode", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        tempAlert.addAction(okAction)
        return tempAlert
    }

}
