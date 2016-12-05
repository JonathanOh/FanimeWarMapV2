//
//  Constants.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/26/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import Foundation
import UIKit


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

// Dummy Data Response

let DummyTeam1 : Dictionary<String, Any> = [
    "teamName" : "abra",
    "teamLocationX" : 200,
    "teamLocationY" : 200,
//    "assignedOnMap" : "Whole Map"
]

let DummyTeam2 : Dictionary<String, Any> = [
    "teamName" : "bulbasaur",
    "teamLocationX" : 200,
    "teamLocationY" : 200,
//    "assignedOnMap" : "Whole Map"
]

let DummyTeam3 : Dictionary<String, Any> = [
    "teamName" : "caterpie",
    "teamLocationX" : 200,
    "teamLocationY" : 200,
//    "assignedOnMap" : "Whole Map"
]

let DummyTeam4 : Dictionary<String, Any> = [
    "teamName" : "charmander",
    "teamLocationX" : 125,
    "teamLocationY" : 200,
    "assignedOnMap" : "Whole Map"
]

let DummyTeam5 : Dictionary<String, Any> = [
    "teamName" : "dratini",
    "teamLocationX" : 200,
    "teamLocationY" : 200,
//    "assignedOnMap" : "Whole Map"
]

let DummyTeam6 : Dictionary<String, Any> = [
    "teamName" : "eevee",
    "teamLocationX" : 200,
    "teamLocationY" : 200,
    "assignedOnMap" : "Whole Map"
]

let DummyTeam7 : Dictionary<String, Any> = [
    "teamName" : "jigglypuff",
    "teamLocationX" : 200,
    "teamLocationY" : 200,
    "assignedOnMap" : "Lower Level Map"
]

let DummyTeam8 : Dictionary<String, Any> = [
    "teamName" : "meowth",
    "teamLocationX" : 200,
    "teamLocationY" : 200,
//    "assignedOnMap" : "Whole Map"
]

let DummyTeam9 : Dictionary<String, Any> = [
    "teamName" : "pikachu",
    "teamLocationX" : 500,
    "teamLocationY" : 100,
    "assignedOnMap" : "Upper Level Map"
]
let DummyTeam10 : Dictionary<String, Any> = [
    "teamName" : "squirtle",
    "teamLocationX" : 0,
    "teamLocationY" : 0,
//    "assignedOnMap" : "Whole Map"
]
//
let DummyResponse : [Dictionary<String, Any?>] = [DummyTeam1, DummyTeam2, DummyTeam3, DummyTeam4, DummyTeam5, DummyTeam6, DummyTeam7, DummyTeam8, DummyTeam9, DummyTeam10]



