//
//  Rover.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/26/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation

class Rover {
    
    private(set) var name : String
    private(set) var phone : String?
    private(set) var team : String?
    private(set) var isAssigned : Bool = false
    
    init(name: String, phone: String?, team: String?) {
        self.name = name
        self.phone = phone
        if let team = team {
            self.team = team
            self.isAssigned = true
        }
    }
    
}
