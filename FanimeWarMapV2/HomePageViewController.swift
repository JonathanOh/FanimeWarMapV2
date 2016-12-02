//
//  HomePageViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/25/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

// TODOS: Save state on maps and their team icons

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MapSelectedDelegate, RoverAddedDelegate, SelectedTeamToDeployDelegate {
    
    @IBOutlet weak var mainMenuTableView: UITableView!
    @IBOutlet weak var mapScrollerSuperView: UIScrollView!
    @IBOutlet weak var mapImageView: UIImageView!

    @IBOutlet weak var widthOfMenuConstraint: NSLayoutConstraint!
    
    private var possibleTeams : [Team] = []
    private var currentRovers : [Rover] = []
    private var currentActiveMap : Map = .WholeMap
    
    private var isInZoomMode : Bool = true
    private var moveTeamsMode : Bool = false
    private var removeTeamsMode : Bool = false
    
    var mainMenuArray : Array<Menu>!
    
    private var arrayOfIcons = [UIImageView]()
    let charmander = UIImageView()
    let squirtle = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMenuArray = Utils.getArrayOfMenuOptions()
        mainMenuTableView.delegate = self
        mainMenuTableView.dataSource = self
        mapScrollerSuperView.delegate = self
        
        mainMenuTableView.backgroundColor = UIColor.white
        
        let button = UIBarButtonItem(title: "Menu Toggle", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = button
        
        view.backgroundColor = FANIME_DARK_BLUE
        setUpBackgroundMap(map: .WholeMap)
        
        possibleTeams = Utils.getCurrentArrayOfTeams()
        
        // This property allows icons to be interacted with by the user
        mapScrollerSuperView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for rover in currentRovers {
            print(rover.name)
        }
    }

    
// MARK : Helper Functions
    func toggleZoomMode() {
        isInZoomMode = !isInZoomMode
        mapScrollerSuperView.isUserInteractionEnabled = !mapScrollerSuperView.isUserInteractionEnabled
        mapScrollerSuperView.zoomScale = 1.0
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
    
    func setUpBackgroundMap(map: Map) {
        
        self.mapScrollerSuperView.minimumZoomScale = 1.0
        self.mapScrollerSuperView.maximumZoomScale = 6.0
        
        self.mapImageView.image = UIImage(named: map.rawValue)
        self.title = map.rawValue

    }
    
    func loadCurrentRovers() {
        //dummy data        
    }
    
    // This allowed pinch zooming for the view returned
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mapImageView
    }
    
// MARK: Table View Delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "mainMenuCellIdentifier")
        cell = UITableViewCell(style: .default, reuseIdentifier: "mainMenuCellIdentifier")
        cell?.textLabel?.text = mainMenuArray[indexPath.row].rawValue
        cell?.textLabel?.textColor = FANIME_ORANGE
        cell?.textLabel?.font = UIFont(name: "SFUIText-Bold", size: 14)
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If Move Teams Mode is enabled, do allow interaction with any other table cell.  Will reselect the Move Teams Cell
        if (removeTeamsMode && mainMenuArray[indexPath.row] != Menu.RemoveTeamsMode) {
            tableView.deselectRow(at: indexPath, animated: true)
            let removeTeamsCellIndex : IndexPath = IndexPath(row: mainMenuArray.index(of: .RemoveTeamsMode)!, section: 0)
            tableView.selectRow(at: removeTeamsCellIndex, animated: true, scrollPosition: .none)
            present(Utils.customWhoopsAlert(message: "You are currently in Remove Teams Mode"), animated: true, completion: nil)
            return
        }
        if (moveTeamsMode && mainMenuArray[indexPath.row] != Menu.MoveTeamsMode) {
            tableView.deselectRow(at: indexPath, animated: true)
            let moveTeamsCellIndex : IndexPath = IndexPath(row: mainMenuArray.index(of: .MoveTeamsMode)!, section: 0)
            tableView.selectRow(at: moveTeamsCellIndex, animated: true, scrollPosition: .none)
            present(Utils.customWhoopsAlert(message: "You are currently in Move Teams Mode"), animated: true, completion: nil)
            return
        }

        tableView.deselectRow(at: indexPath, animated: true)
    
        switch mainMenuArray[indexPath.row] {
        case .MapPicker:
            performSegue(withIdentifier: SegueId.mapPickerId, sender: self)
        case .AddARover:
            // This needs to be passed active teams
            performSegue(withIdentifier: SegueId.addRoverId, sender: self)
        case .DeployTeam:
            performSegue(withIdentifier: SegueId.deployTeamId, sender: self)
        case .ViewTeams:
            performSegue(withIdentifier: SegueId.viewTeamId, sender: self)
        case .SaveMap:
            //Learn Firebase
            present(Utils.placeHolderAlert(), animated: true, completion: nil)
        case .MoveTeamsMode:
            if !moveTeamsMode {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
            moveTeamsMode = !moveTeamsMode
            toggleZoomMode()
        case .RemoveTeamsMode:
            if !removeTeamsMode {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
            removeTeamsMode = !removeTeamsMode
            toggleZoomMode()
            //get deployable teams via utils function then pass touch point
            
            // This needs to be passed active rovers
            //present(Utils.placeHolderAlert(), animated: true, completion: nil)
        case .LogOut:
            self.dismiss(animated: true, completion: nil)
        default:
            print("default case")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

// MARK: Touch Events
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if moveTeamsMode {
            let deployedTeams = Utils.getDeployedTeams(teams: possibleTeams)
            for touch in touches {
                let touchLocation = touch.location(in: self.mapImageView)
                guard let teamToMove = Utils.closestTeamToTouchEvent(touchPoint: touchLocation, arrayOfTeams: deployedTeams) else { return }
                guard let teamIconView = teamToMove.teamIconView else { return }
                teamIconView.center = touchLocation
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if removeTeamsMode {
            let deployedTeams = Utils.getDeployedTeams(teams: possibleTeams)
            for touch in touches {
                let touchLocation = touch.location(in: self.mapImageView)
                guard let teamToRemove = Utils.closestTeamToTouchEvent(touchPoint: touchLocation, arrayOfTeams: deployedTeams) else { return }
                present(Utils.removeTeamAlert(team: teamToRemove), animated: true, completion: nil)
            }
        }
    }
  
// MARK: Custom Delegates
    func mapWasSelected(map: Map) {
        setUpBackgroundMap(map: map)
    }
    
    func roverWasAdded(rover: Rover) {
        currentRovers.append(rover)
    }
    
    func teamWasSelectedToDeploy(team: Team, map: Map) {
        team.teamWasDeployed(map: map)
        if let teamIconView = team.teamIconView {
            mapImageView.addSubview(teamIconView)
            arrayOfIcons.append(teamIconView)
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
        case SegueId.addRoverId:
            let AddRoverVC : AddRoverViewController = segue.destination as! AddRoverViewController
            AddRoverVC.delegate = self
        case SegueId.deployTeamId:
            let DeployTeamVC : DeployTeamViewController = segue.destination as! DeployTeamViewController
            let deployableTeams = Utils.getDeployableTeams(teams: possibleTeams)
            DeployTeamVC.deployableTeams = deployableTeams
            DeployTeamVC.currentMapBeingDeployedTo = currentActiveMap
            DeployTeamVC.delegate = self
        case SegueId.viewTeamId:
            let ViewTeamVC : ViewTeamsViewController = segue.destination as! ViewTeamsViewController
            ViewTeamVC.currentTeams = possibleTeams
            
        default:
            return
        }
    }
    
}
