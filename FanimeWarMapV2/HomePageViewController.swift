//
//  HomePageViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/25/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MapSelectedDelegate, RoverAddedDelegate, SelectedTeamToDeployDelegate {
    
    @IBOutlet weak var mainMenuTableView: UITableView!
    @IBOutlet weak var mapScrollerSuperView: UIScrollView!
    @IBOutlet weak var mapImageView: UIImageView!

    @IBOutlet weak var widthOfMenuConstraint: NSLayoutConstraint!
    
    private var activeTeams : [Team] = []
    private var currentRovers : [Rover] = []
    private var dictionaryOfTeams = [String : [Team]]()
    
    private var isInZoomMode : Bool = true
    
    var mainMenuArray : Array<String>!
    
    var iconToMove = UIImageView()
    var minimumDistanceToMoveClosestIcon : CGFloat = 0
    
    private var arrayOfIcons = [UIImageView]()
    let charmander = UIImageView()
    let squirtle = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMenuArray = [MainMenu.mapPicker, MainMenu.addATeam, MainMenu.addARover, MainMenu.deployTeam, MainMenu.viewTeams, MainMenu.saveMap, MainMenu.moveTeamsMode, MainMenu.logOut]
        mainMenuTableView.delegate = self
        mainMenuTableView.dataSource = self
        mapScrollerSuperView.delegate = self
        
        mainMenuTableView.backgroundColor = UIColor.white
        
        let button = UIBarButtonItem(title: "Menu Toggle", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = button
        
        view.backgroundColor = FANIME_DARK_BLUE
        setUpBackgroundMap(map: MapName.wholeMap)
        
        loadCurrentRovers()
        loadCurrentTeamsIntoArray()
        loadDictionaryOfTeams()
        
        
        charmander.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        charmander.image = UIImage(named: "charmander")
        charmander.tag = 0
        squirtle.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        squirtle.image = UIImage(named: "squirtle")
        squirtle.tag = 1
        arrayOfIcons = [charmander, squirtle]
        // This property allows icons to be interacted with by the user
        mapScrollerSuperView.isUserInteractionEnabled = true
        
        mapImageView.addSubview(charmander)
        mapImageView.addSubview(squirtle)
        
        print(squirtle.center)
        print(charmander.center)

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
    
    func setUpBackgroundMap(map: String) {
        
        self.mapScrollerSuperView.minimumZoomScale = 1.0
        self.mapScrollerSuperView.maximumZoomScale = 6.0
        
        self.mapImageView.image = UIImage(named: map)
        self.title = map

    }
  
    func loadDictionaryOfTeams() {
        
        var teamHolder : [Team] = []
        
        for pokemon in Pokemon {
            let team = Team(name: pokemon, icon: pokemon)
            teamHolder.append(team)
        }
        dictionaryOfTeams["deployed"] = []
        dictionaryOfTeams["undeployed"] = teamHolder
    
    }
    
    func loadCurrentRovers() {
        //dummy data
//        let dummyRoverData = ["Hanson", "Starry", "Jay", "Michael", "Jenny", "Stacey", "Greg", "Aston", "Sara", "LeeSin"]
//        let dummyAssignment = ["Pikachu", nil, "Pikachu", nil, "Squirtle", "Squirtle", "Squirtle", "Squirtle", nil, nil]
//        
//        for item in dummyRoverData {
//            let currentIndex = dummyRoverData.index(of: item)
//            let rover = Rover(name: item, phone: nil, team: dummyAssignment[currentIndex!])
//            self.currentRovers.append(rover)
//        }
        
    }
    
    func loadCurrentTeamsIntoArray() {
        //currently dummy data, this is where we will pull current teams from network
//        let dummyDataTeamName = ["Pikachu", "Squirtle", "Bulbasaur", "Raichu", "Charizard"]
//        let dummyDataTeamIcon = ["PikachuIcon", "SquirtleIcon", "BulbasaurIcon", "RaichuIcon", "CharizardIcon"]
//        let dummyDataTeamMembers = [["Jon", "Phil"], ["Chris", "Waffles"], ["Alicia", "Mike"], ["Steven", "Chris"], ["JJ", "Harambe"]]
//        
//        for name in dummyDataTeamName {
//            let currentIndex = dummyDataTeamName.index(of: name)
//            let team = Team(name: name, icon: dummyDataTeamIcon[currentIndex!])
//            team.replaceCurrentTeamWith(team: dummyDataTeamMembers[currentIndex!])
//            activeTeams.append(team)
//        }
    }
    
    // This allowed pinch zooming for the view returned
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mapImageView
    }
    
    func placeHolderAlert() {
        let tempAlert = UIAlertController(title: "Whoops!", message: "This is currently in development", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        tempAlert.addAction(okAction)
        present(tempAlert, animated: true, completion: nil)
    }
    
// MARK: Table View Delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "mainMenuCellIdentifier")
        cell = UITableViewCell(style: .default, reuseIdentifier: "mainMenuCellIdentifier")
        cell?.textLabel?.text = mainMenuArray[indexPath.row]
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
        if (!isInZoomMode && mainMenuArray[indexPath.row] != MainMenu.moveTeamsMode) {
            tableView.deselectRow(at: indexPath, animated: true)
            let moveTeamsCellIndex : IndexPath = IndexPath(row: mainMenuArray.index(of: MainMenu.moveTeamsMode)!, section: 0)
            tableView.selectRow(at: moveTeamsCellIndex, animated: true, scrollPosition: .none)
            return
        }
        if (mainMenuArray[indexPath.row] != MainMenu.moveTeamsMode) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
        switch mainMenuArray[indexPath.row] {
        case MainMenu.mapPicker:
            performSegue(withIdentifier: SegueId.mapPickerId, sender: self)
        case MainMenu.addATeam:
            // This needs to be passed active rovers
            placeHolderAlert()
        case MainMenu.addARover:
            // This needs to be passed active teams
            performSegue(withIdentifier: SegueId.addRoverId, sender: self)
        case MainMenu.deployTeam:
            performSegue(withIdentifier: SegueId.deployTeamId, sender: self)
        case MainMenu.viewTeams:
            performSegue(withIdentifier: SegueId.viewTeamId, sender: self)
        case MainMenu.saveMap:
            //Learn Firebase
            placeHolderAlert()
        case MainMenu.moveTeamsMode:
            if isInZoomMode {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
            toggleZoomMode()
        case MainMenu.logOut:
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
        for touch in touches {
            let touchLocation = touch.location(in: self.mapImageView)
            let imageToMove = closestImageToTouchEvent(touchPoint: touchLocation)
            
            if let imageToMove = imageToMove {
                imageToMove.center = touchLocation
            }
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let touchLocation = touch.location(in: self.mapImageView)
//            let imageToMove = closestImageToTouchEvent(touchPoint: touchLocation)
//            
//            if let imageToMove = imageToMove {
//                imageToMove.center = touchLocation
//            }
//        }
//    }

    func closestImageToTouchEvent(touchPoint: CGPoint) -> UIImageView? {
        //let arrayOfIcons = [squirtle, charmander]
        var closestImageToTouch : UIImageView?
        var closestDistanceValue : CGFloat = -1.0 // Use a default place holder value of -1
        
        for icon in arrayOfIcons {
            let xDistance = abs(icon.center.x - touchPoint.x)
            let yDistance = abs(icon.center.y - touchPoint.y)
            let currentDistanceValue : CGFloat = xDistance + yDistance
            if closestDistanceValue == -1 {
                closestDistanceValue = currentDistanceValue
                closestImageToTouch = icon
            } else if (currentDistanceValue < closestDistanceValue) {
                closestDistanceValue = currentDistanceValue
                closestImageToTouch = icon
            }
        }
        let fingerIsCloseEnoughToImageToMoveImage = closestDistanceValue > 60
        if fingerIsCloseEnoughToImageToMoveImage {
            closestImageToTouch = nil
        }
        return closestImageToTouch
    }
  
// MARK: Custom Delegates
    func mapWasSelected(map: String) {
        setUpBackgroundMap(map: map)
    }
    
    func roverWasAdded(rover: Rover) {
        currentRovers.append(rover)
    }
    
    func teamWasSelectedToDeploy(team: Team) {
        //mutate current standing dictionary of teams
        //create image icon of team and add the subview to image
        let teamIconToAddToView = UIImageView(image: team.teamIcon)
        
        teamIconToAddToView.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        
        //squirtle.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        //squirtle.image = UIImage(named: "squirtle")
        mapImageView.addSubview(teamIconToAddToView)
        

        arrayOfIcons.append(teamIconToAddToView)

        print(arrayOfIcons.count)
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
            DeployTeamVC.deployableTeams = dictionaryOfTeams["undeployed"]!
            DeployTeamVC.delegate = self
        case SegueId.viewTeamId:
            let ViewTeamVC : ViewTeamsViewController = segue.destination as! ViewTeamsViewController
            ViewTeamVC.currentTeams = activeTeams
            
        default:
            return
        }
    }
    
}
