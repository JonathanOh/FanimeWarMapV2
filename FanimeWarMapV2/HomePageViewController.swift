//
//  HomePageViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/25/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MapSelectedDelegate, RoverAddedDelegate {
    
    @IBOutlet weak var mainMenuTableView: UITableView!
    @IBOutlet weak var mapScrollerSuperView: UIScrollView!
    @IBOutlet weak var mapImageView: UIImageView!

    @IBOutlet weak var widthOfMenuConstraint: NSLayoutConstraint!
    
    private var activeTeams : [Team] = []
    private var currentRovers : [Rover] = []
    private var backgroundMap : UIColor = UIColor.green
    
    var mainMenuArray : Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMenuArray = [MainMenu.mapPicker, MainMenu.addATeam, MainMenu.addARover, MainMenu.deployTeam, MainMenu.viewTeams, MainMenu.saveMap, MainMenu.zoomMode, MainMenu.logOut]
        self.mainMenuTableView.delegate = self
        self.mainMenuTableView.dataSource = self
        self.mapScrollerSuperView.delegate = self
        
        self.mainMenuTableView.backgroundColor = UIColor.lightGray
        
        let button = UIBarButtonItem(title: "Menu Toggle", style: .plain, target: self, action: #selector(toggleMenu))
        self.navigationItem.leftBarButtonItem = button
        
        self.setUpBackgroundMap(map: backgroundMap)
        
        loadCurrentRovers()
        loadCurrentTeamsIntoArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for rover in currentRovers {
            print(rover.name)
        }
    }
    
    func toggleMenu() {
        let constant = self.widthOfMenuConstraint.constant
        if constant == 0 {
            self.widthOfMenuConstraint.constant = 200.0
        } else {
            self.widthOfMenuConstraint.constant = 0.0
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func setUpBackgroundMap(map: UIColor) {
        
        self.mapScrollerSuperView.minimumZoomScale = 1.0
        self.mapScrollerSuperView.maximumZoomScale = 6.0
        
        self.view.backgroundColor = map
    }
  
    func loadCurrentRovers() {
        //dummy data
        let dummyRoverData = ["Hanson", "Starry", "Jay", "Michael", "Jenny", "Stacey", "Greg", "Aston", "Sara", "LeeSin"]
        let dummyAssignment = ["Pikachu", nil, "Pikachu", nil, "Squirtle", "Squirtle", "Squirtle", "Squirtle", nil, nil]
        
        for item in dummyRoverData {
            let currentIndex = dummyRoverData.index(of: item)
            let rover = Rover(name: item, phone: nil, team: dummyAssignment[currentIndex!])
            self.currentRovers.append(rover)
        }
        
    }
    
    func loadCurrentTeamsIntoArray() {
        //currently dummy data, this is where we will pull current teams from network
        let dummyDataTeamName = ["Pikachu", "Squirtle", "Bulbasaur", "Raichu", "Charizard"]
        let dummyDataTeamIcon = ["PikachuIcon", "SquirtleIcon", "BulbasaurIcon", "RaichuIcon", "CharizardIcon"]
        let dummyDataTeamMembers = [["Jon", "Phil"], ["Chris", "Waffles"], ["Alicia", "Mike"], ["Steven", "Chris"], ["JJ", "Harambe"]]
        
        for name in dummyDataTeamName {
            let currentIndex = dummyDataTeamName.index(of: name)
            let team = Team(name: name, icon: dummyDataTeamIcon[currentIndex!])
            team.replaceCurrentTeamWith(team: dummyDataTeamMembers[currentIndex!])
            activeTeams.append(team)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mapImageView
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
        tableView.deselectRow(at: indexPath, animated: true)
        switch mainMenuArray[indexPath.row] {
        case MainMenu.mapPicker:
            performSegue(withIdentifier: SegueId.mapPickerId, sender: self)
            break
        case MainMenu.addATeam:
            // This needs to be passed active rovers
            break
        case MainMenu.addARover:
            // This needs to be passed active teams
            performSegue(withIdentifier: SegueId.addRoverId, sender: self)
            break
        case MainMenu.deployTeam:
            // This needs to be passed active teams without a location
            break
        case MainMenu.viewTeams:
            performSegue(withIdentifier: SegueId.viewTeamId, sender: self)
            break
        case MainMenu.saveMap:
            //Learn Firebase
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
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
    
    func roverWasAdded(rover: Rover) {
        currentRovers.append(rover)
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
        case SegueId.addRoverId:
            let AddRoverVC : AddRoverViewController = segue.destination as! AddRoverViewController
            AddRoverVC.delegate = self
            break
        case SegueId.viewTeamId:
            let ViewTeamVC : ViewTeamsViewController = segue.destination as! ViewTeamsViewController
            ViewTeamVC.currentTeams = activeTeams
            break
        default:
            return
        }
    }
    
}
