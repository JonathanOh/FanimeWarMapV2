//
//  Constants.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/26/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation
import UIKit

struct MainMenu {
    static let mapPicker = "Map Picker"
    static let addATeam = "Add a Team"
    static let addARover = "Add a Rover"
    static let deployTeam = "Deploy Team"
    static let viewTeams = "View Teams"
    static let saveMap = "Save/Upload Map"
    static let moveTeamsMode = "Move Teams Mode"
    static let logOut = "Log Out"
}

struct MapName {
    static let mapOne = "Map 1 Green"
    static let mapTwo = "Map 2 Blue"
    static let mapThree = "Map 3 Yellow"
    static let wholeMap = "Whole Map"
    static let upperLevelMap = "Upper Level Map"
    static let lowerLevelMap = "Lower Level Map"
}

struct SegueId {
    static let mapPickerId = "mapPickerSegue"
    static let viewTeamId = "viewTeamSegue"
    static let addRoverId = "addRoverSegue"
}

let FANIME_DARK_BLUE : UIColor = UIColor(red: 17.0/255.0, green: 45.0/255.0, blue: 85.0/255.0, alpha: 1)
let FANIME_ORANGE : UIColor = UIColor(red: 244.0/255.0, green: 121.0/255.0, blue: 32.0/255.0, alpha: 1)

let Pokemon : [String] = ["Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise",
                          "Caterpie", "Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata",
                          "Raticate", "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Nidoran", "Nidorina",
                          "Nidoqueen", "Clefairy", "Clefable", "Vulpix", "Nintales", "Jgglypuff", "Jigglytuff", "Zubat", "Golbat", "Oddish", "Gloom",
                          "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth", "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck",
                          "Mankey", "Primeape", "Growlith", "Arcanine"]
