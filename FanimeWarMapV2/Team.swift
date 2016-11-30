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
    private(set) var teamLocation : Int?
    private(set) var teamIcon : UIImage?
    
    init(name: String, icon: String) {
        self.teamName = name
        
        guard let teamIcon = UIImage(named: icon) else {
            return
        }
        self.teamIcon = teamIcon
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
    
}
