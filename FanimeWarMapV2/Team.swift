//
//  Team.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/26/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation
import UIKit

class Team {
    
    private(set) var teamName : String
    private(set) var teamMembers : [String] = ["No Team Members"]
    private(set) var teamLocation : CGPoint?
    private(set) var teamIcon : UIImage?
    private(set) var teamIconView : UIImageView?
    private(set) var assignedOnMap : Map?
    private(set) var isTeamDeployed : Bool = false
    
    init(name: String, icon: String) {
        self.teamName = name
        
        guard let teamIcon = UIImage(named: icon) else {
            return
        }
        self.teamIcon = teamIcon
        teamIconView = UIImageView(image: teamIcon)
        teamIconView?.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
    }
    
    func replaceCurrentTeamWith(team: [String]) {
        self.teamMembers = team
    }
    
    func addToCurrentTeam(name: String) {
        if self.teamMembers[0] == "No Team Members" {
            self.teamMembers = []
        }
        teamMembers.append(name)
    }
    
    func teamWasDeployed(map: Map) {
        isTeamDeployed = true
        assignedOnMap = map
        teamLocation = STARTING_POINT
        teamIconView?.center = STARTING_POINT
    }
    
    func teamWasUndeployed() {
        isTeamDeployed = false
        assignedOnMap = nil
        teamLocation = nil
        teamIconView?.removeFromSuperview()
    }
    
    func updateTeamLocationTo(point: CGPoint) {
        teamLocation = point
        teamIconView?.center = point
    }
    
    func setupLocationAndMap(map: Map, xLocation: Int, yLocation: Int) {
        isTeamDeployed = true
        let location = CGPoint(x: xLocation, y: yLocation)
        updateTeamLocationTo(point: location)
        assignedOnMap = map
    }
    
}
