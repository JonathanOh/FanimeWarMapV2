//
//  Team.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/26/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation

class Team {
    
    private(set) var teamName : String
    private(set) var teamMembers : [String]?
    private(set) var teamLocation : Int?
    private(set) var teamIcon : String
    
    init(name: String, icon: String) {
        self.teamName = name
        self.teamIcon = icon
    }
    
}
