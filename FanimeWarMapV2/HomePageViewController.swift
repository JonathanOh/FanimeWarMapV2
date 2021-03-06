//
//  HomePageViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/25/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

// TODOS: Save state on maps and their team icons

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MapSelectedDelegate, RoverAddedDelegate, SelectedTeamToDeployDelegate, MapValueWasEditedDelegate {
    
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
        
        //let button = UIBarButtonItem(title: "Menu Toggle", style: .plain, target: self, action: #selector(toggleMenu))
        //navigationItem.leftBarButtonItem = button
        
        view.backgroundColor = FANIME_DARK_BLUE
        setUpBackgroundMap(map: .WholeMap)
        
        possibleTeams = Utils.getCurrentArrayOfTeams()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        self.mapImageView.addGestureRecognizer(longPressRecognizer)
        
        // This property allows icons to be interacted with by the user
        mapScrollerSuperView.isUserInteractionEnabled = true
        
        DataService.sharedIntances.getPossibleTeams { (teams: [Team]) in
            self.loadRoversWith(response: teams)
        }
        
        //loadCurrentRoversWithResponse(response: DummyResponse, currentTeams: possibleTeams)
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
        currentActiveMap = map
        self.mapScrollerSuperView.minimumZoomScale = 1.0
        self.mapScrollerSuperView.maximumZoomScale = 6.0
        
        self.mapImageView.image = UIImage(named: map.rawValue)
        self.title = map.rawValue
    }
    
    func loadRoversWith(response: [Team]) {
        possibleTeams = response
        for team in possibleTeams {
            guard let map = team.assignedOnMap else { continue }
            if map == currentActiveMap {
                mapImageView.addSubview(team.teamIconView!)
            }
        }
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
        
        if mainMenuArray[indexPath.row] == .DeployTeam || mainMenuArray[indexPath.row] == .MoveTeamsMode || mainMenuArray[indexPath.row] == .RemoveTeamsMode {
            cell?.contentView.backgroundColor = UIColor.black
        }
        
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
//        case .AddARover:
//            // This needs to be passed active teams
//            performSegue(withIdentifier: SegueId.addRoverId, sender: self)
        case .DeployTeam:
            performSegue(withIdentifier: SegueId.deployTeamId, sender: self)
        case .RemoveTeams:
            let removeAlert = Utils.customWhoopsAlert(message: "You really want to remove and reset all teams?")
            let doRemoveAllTeams = UIAlertAction(title: "Yes, Reset ALL!", style: .destructive, handler: { [weak self] (alert: UIAlertAction) in
                guard let unwrappedSelf = self else { return }
                for team in unwrappedSelf.possibleTeams {
                    team.teamWasUndeployed()
                }
            })
            removeAlert.addAction(doRemoveAllTeams)
            present(removeAlert, animated: true, completion: nil)
        //performSegue(withIdentifier: SegueId.viewTeamId, sender: self)
        case .SaveMap:
            if User.sharedIntances.admin != Admin.Admin {
                let alert = Utils.customWhoopsAlert(message: "You don't have admin access to save!")
                present(alert, animated: true, completion: nil)
                return
            }
            DataService.sharedIntances.saveTeamLocations(teams: possibleTeams, success: { (success) in
                if success {
                    let alert = Utils.mapWasSavedAlert()
                    self.present(alert, animated: false, completion: nil)
                }
            })
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
        case .LogOut:
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

// MARK: Touch Events
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if moveTeamsMode {
            let teamsOnMap = Utils.getTeamsForGivenMap(teams: possibleTeams, map: currentActiveMap)
            for touch in touches {
                let touchLocation = touch.location(in: self.mapImageView)
                guard let teamToMove = Utils.closestTeamToTouchEvent(touchPoint: touchLocation, arrayOfTeams: teamsOnMap) else { return }
                teamToMove.updateTeamLocationTo(point: touchLocation)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if removeTeamsMode {
            let teamsOnMap = Utils.getTeamsForGivenMap(teams: possibleTeams, map: currentActiveMap)
            for touch in touches {
                let touchLocation = touch.location(in: self.mapImageView)
                guard let teamToRemove = Utils.closestTeamToTouchEvent(touchPoint: touchLocation, arrayOfTeams: teamsOnMap) else { return }
                present(Utils.removeTeamAlert(team: teamToRemove), animated: true, completion: nil)
            }
        }
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        let longTouchPoint = sender.location(in: self.mapImageView)
        let closestTeam: Team? = Utils.closestTeamToTouchEvent(touchPoint: longTouchPoint, arrayOfTeams: possibleTeams)
        guard let team = closestTeam else { return }
        if self.presentedViewController == nil {
            let teamInfoAlert: UIAlertController = Utils.teamInfoAlert(team: team)
            let editTeam = UIAlertAction(title: "Edit Team", style: .default) { (action: UIAlertAction) in
                let editTeamViewController: EditTeamViewController = EditTeamViewController()
                editTeamViewController.teamBeingEdited = team
                editTeamViewController.delegate = self
                self.present(editTeamViewController, animated: true, completion: nil)
            }
            let removeTeam = UIAlertAction(title: "Remove Team", style: .default) { (action: UIAlertAction) in
                team.teamWasUndeployed()
            }
            teamInfoAlert.addAction(editTeam)
            teamInfoAlert.addAction(removeTeam)
            present(teamInfoAlert, animated: true, completion: nil)
        }
    }
  
// MARK: Custom Delegates
    func mapWasSelected(map: Map) {
        Utils.removeTeamIconsFromMap(teams: possibleTeams, map: currentActiveMap)
        setUpBackgroundMap(map: map)
        let teamsInMap = Utils.getTeamsForGivenMap(teams: possibleTeams, map: map)
        Utils.layoutTeamsInImageView(teams: teamsInMap, imageView: mapImageView)
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
            MapPickerVC.numberOfTeamsOnMapDict = Utils.numberOfTeamsOnMap(teams: possibleTeams)
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
