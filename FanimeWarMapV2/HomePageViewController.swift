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
    
    private var teams : [Team]?
    private var backgroundMap : UIColor = UIColor.green
    
    let mapPickerMenu = "Map Picker"
    let addATeamMenu = "Add a Team"
    let addARoverMenu = "Add a Rover"
    let deployTeamMenu = "Deploy Team"
    let viewTeamsMenu = "View Teams"
    let saveMapMenu = "Save/Upload Map"
    let zoomModeMenu = "Zoom Mode"
    let logOutMenu = "Log Out"
    
    var mainMenuArray : Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMenuArray = [mapPickerMenu, addATeamMenu, addARoverMenu, deployTeamMenu, viewTeamsMenu, saveMapMenu, zoomModeMenu, logOutMenu]
        
        self.mainMenuTableView.delegate = self
        self.mainMenuTableView.dataSource = self
    
        self.setUpBackgroundMap(map: backgroundMap)
        
    }
    
    func setUpBackgroundMap(map: UIColor) {
        self.view.backgroundColor = map
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
        case mapPickerMenu:
            performSegue(withIdentifier: "mapPickerSegue", sender: self)
            print(mapPickerMenu)
            break
        case addATeamMenu:
            print(addATeamMenu)
            break
        case addARoverMenu:
            print(addARoverMenu)
            break
        case deployTeamMenu:
            print(deployTeamMenu)
            break
        case viewTeamsMenu:
            print(viewTeamsMenu)
            break
        case saveMapMenu:
            print(saveMapMenu)
            break
        case zoomModeMenu:
            print(zoomModeMenu)
            break
        case logOutMenu:
            self.dismiss(animated: true, completion: nil)
            break
        default:
            print("default case")
        }
    }
        
    func mapWasSelected(map: String) {
        switch map {
        case "Map 1 Green":
            setUpBackgroundMap(map: UIColor.green)
            break
        case "Map 2 Blue":
            setUpBackgroundMap(map: UIColor.blue)
            break
        case "Map 3 Yellow":
            setUpBackgroundMap(map: UIColor.yellow)
            break
        default:
            setUpBackgroundMap(map: UIColor.green)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapPickerSegue" {
            let MapPickerVC : MapPickerViewController = segue.destination as! MapPickerViewController
            MapPickerVC.delegate = self
        }
    }
    
}
