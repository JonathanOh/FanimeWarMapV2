//
//  Rover.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/26/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation

class Rover {
    
    private var name : String
    private var phone : Int?
    private var team : String?
    private var isAssigned : Bool = false
    
    init(name: String, phone: Int?, team: String?) {
        self.name = name
        self.phone = phone
        if let team = team {
            self.team = team
            self.isAssigned = true
        }
    }
    
}
