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
    private(set) var teamLabelName : String
    private(set) var teamMembers : [String] = ["No Team Members"]
    private(set) var teamLocation : CGPoint?
    private(set) var teamIcon : UIImage?
    private(set) var teamIconView : UIImageView?
    private(set) var assignedOnMap : Map?
    private(set) var isTeamDeployed : Bool = false
    private(set) var teamLabel: UILabel!
    
    init(name: String, icon: String) {
        self.teamName = name
        self.teamLabelName = name
        
        guard let teamIcon = UIImage(named: icon) else { return }
        
        self.teamIcon = teamIcon
        teamIconView = UIImageView(image: teamIcon)
        
        guard let teamIconView = teamIconView else { return }
        teamIconView.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        
        self.teamLabel = UILabel()
        self.teamLabel.translatesAutoresizingMaskIntoConstraints = false
        self.teamLabel.backgroundColor = UIColor.black
        self.teamLabel.textAlignment = .center
        self.teamLabel.textColor = UIColor.white
        self.teamLabel.text = name
        teamIconView.addSubview(self.teamLabel)
        
        self.teamLabel.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        self.teamLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        self.teamLabel.topAnchor.constraint(equalTo: teamIconView.topAnchor, constant: 37).isActive = true
        self.teamLabel.centerXAnchor.constraint(equalTo: teamIconView.centerXAnchor, constant: 0.0).isActive = true
        
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
        updateTeamLabel(name: teamName)
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
    
    func updateTeamMembers(members: [String]) {
        self.teamMembers = members
    }
    func updateTeamLabel(name: String) {
        self.teamLabelName = name
        self.teamLabel.text = name
    }
    func doesTeamHaveNoMembers() -> Bool {
        return self.teamMembers == ["No Team Members"]
    }
    
}
