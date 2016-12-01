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
        return [MainMenu.mapPicker, MainMenu.addATeam, MainMenu.addARover, MainMenu.deployTeam, MainMenu.viewTeams, MainMenu.saveMap, MainMenu.moveTeamsMode, MainMenu.logOut]
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
    
    static func getCurrentArrayOfTeams() -> [Team] {
        var teamHolder : [Team] = []
        
        for pokemon in Pokemon {
            let team = Team(name: pokemon, icon: pokemon)
            teamHolder.append(team)
        }
        return teamHolder
    }
    
    static func closestImageToTouchEvent(touchPoint: CGPoint, arrayOfIcons: [UIImageView]) -> UIImageView? {
        var closestImageToTouch : UIImageView?
        var closestDistanceValue : CGFloat = -1.0 // Use a default place holder value of -1
        
        for icon in arrayOfIcons {
            let xDistance = abs(icon.center.x - touchPoint.x)
            let yDistance = abs(icon.center.y - touchPoint.y)
            let currentDistanceValue : CGFloat = xDistance + yDistance
            if closestDistanceValue == -1 {
                closestDistanceValue = currentDistanceValue
                closestImageToTouch = icon
            } else if (currentDistanceValue < closestDistanceValue) {
                closestDistanceValue = currentDistanceValue
                closestImageToTouch = icon
            }
        }
        let fingerIsCloseEnoughToImageToMoveImage = closestDistanceValue > 60
        if fingerIsCloseEnoughToImageToMoveImage {
            closestImageToTouch = nil
        }
        return closestImageToTouch
    }

}
