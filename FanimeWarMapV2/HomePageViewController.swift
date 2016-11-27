//
//  HomePageViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/25/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MapSelectedDelegate {
    
    @IBOutlet weak var mainMenuTableView: UITableView!
    
    private var teams : [Team] = []
    private var backgroundMap : UIColor = UIColor.green
    
    var mainMenuArray : Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMenuArray = [MainMenu.mapPicker, MainMenu.addATeam, MainMenu.addARover, MainMenu.deployTeam, MainMenu.viewTeams, MainMenu.saveMap, MainMenu.zoomMode, MainMenu.logOut]
        self.mainMenuTableView.delegate = self
        self.mainMenuTableView.dataSource = self
        
        self.setUpBackgroundMap(map: backgroundMap)
        
        loadCurrentTeamsIntoArray()
        
    }
    
    func setUpBackgroundMap(map: UIColor) {
        self.view.backgroundColor = map
    }
  
    func loadCurrentTeamsIntoArray() {
        //currently dummy data, this is where we will pull current teams from network
        let dummyDataTeamName = ["Pikachu", "Squirtle", "Bulbasaur", "Raichu", "Charizard"]
        let dummyDataTeamIcon = ["PikachuIcon", "SquirtleIcon", "BulbasaurIcon", "RaichuIcon", "CharizardIcon"]
        
        for name in dummyDataTeamName {
            let currentIndex = dummyDataTeamName.index(of: name)
            let team = Team(name: name, icon: dummyDataTeamIcon[currentIndex!])
            teams.append(team)
        }
        print(self.teams)
        
    }
    
    
// MARK: Table View Delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "mainMenuCellIdentifier")
        cell = UITableViewCell(style: .default, reuseIdentifier: "mainMenuCellIdentifier")
        cell?.textLabel?.text = mainMenuArray[indexPath.row]
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch mainMenuArray[indexPath.row] {
        case MainMenu.mapPicker:
            performSegue(withIdentifier: SegueId.mapPickerId, sender: self)
            break
        case MainMenu.addATeam:
            break
        case MainMenu.addARover:
            break
        case MainMenu.deployTeam:
            break
        case MainMenu.viewTeams:
            performSegue(withIdentifier: SegueId.viewTeamId, sender: self)
            break
        case MainMenu.saveMap:
            break
        case MainMenu.zoomMode:
            break
        case MainMenu.logOut:
            self.dismiss(animated: true, completion: nil)
            break
        default:
            print("default case")
        }
    }
    
  
// MARK: Custom Delegates
    func mapWasSelected(map: String) {
        switch map {
        case MapName.mapOne:
            setUpBackgroundMap(map: UIColor.green)
            break
        case MapName.mapTwo:
            setUpBackgroundMap(map: UIColor.blue)
            break
        case MapName.mapThree:
            setUpBackgroundMap(map: UIColor.yellow)
            break
        default:
            setUpBackgroundMap(map: UIColor.green)
        }
    }
// MARK: prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else {
            return
        }
        
        switch segueId {
        case SegueId.mapPickerId:
            let MapPickerVC : MapPickerViewController = segue.destination as! MapPickerViewController
            MapPickerVC.delegate = self
            break
        case SegueId.viewTeamId:
            let ViewTeamVC : ViewTeamsViewController = segue.destination as! ViewTeamsViewController
            ViewTeamVC.currentTeams = teams
            break
        default:
            return
        }
        
        
//        if segue.identifier == SegueId.mapPickerId {
//            let MapPickerVC : MapPickerViewController = segue.destination as! MapPickerViewController
//            MapPickerVC.delegate = self
//        }
    }
    
}
