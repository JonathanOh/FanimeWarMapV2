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
    static let addARover = "Add a Rover"
    static let deployTeam = "Deploy Team"
    static let viewTeams = "View Teams"
    static let saveMap = "Save/Upload Map"
    static let moveTeamsMode = "Move Teams Mode"
    static let removeTeamsMode = "Remove Teams Mode"
    static let logOut = "Log Out"
}
enum Menu : String {
    case MapPicker = "Map Picker"
    case AddARover = "Add a Rover"
    case DeployTeam = "Deploy Team"
    case ViewTeams = "View Teams"
    case SaveMap = "Save/Upload Map"
    case MoveTeamsMode = "Move Teams Mode"
    case RemoveTeamsMode = "Remove Teams Mode"
    case LogOut = "Log Out"
}

//struct MapName {
//    static let mapOne = "Map 1 Green"
//    static let mapTwo = "Map 2 Blue"
//    static let mapThree = "Map 3 Yellow"
//    static let wholeMap = "Whole Map"
//    static let upperLevelMap = "Upper Level Map"
//    static let lowerLevelMap = "Lower Level Map"
//}

enum Map : String {
    case WholeMap = "Whole Map"
    case UpperLevelMap = "Upper Level Map"
    case LowerLevelMap = "Lower Level Map"
}

struct SegueId {
    static let mapPickerId = "mapPickerSegue"
    static let viewTeamId = "viewTeamSegue"
    static let addRoverId = "addRoverSegue"
    static let deployTeamId = "deployTeamSegue"
}

let STARTING_POINT = CGPoint(x: 40, y: 20)

let FANIME_DARK_BLUE : UIColor = UIColor(red: 17.0/255.0, green: 45.0/255.0, blue: 85.0/255.0, alpha: 1)
let FANIME_ORANGE : UIColor = UIColor(red: 244.0/255.0, green: 121.0/255.0, blue: 32.0/255.0, alpha: 1)

let Pokemon : [String] = ["abra", "bulbasaur", "caterpie", "charmander", "dratini", "eevee", "jigglypuff", "meowth", "pikachu", "squirtle"]
    
//    ["Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise",
//                          "Caterpie", "Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata",
//                          "Raticate", "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Nidoran", "Nidorina",
//                          "Nidoqueen", "Clefairy", "Clefable", "Vulpix", "Nintales", "Jgglypuff", "Jigglytuff", "Zubat", "Golbat", "Oddish", "Gloom",
//                          "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth", "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck",
//                          "Mankey", "Primeape", "Growlith", "Arcanine"]
