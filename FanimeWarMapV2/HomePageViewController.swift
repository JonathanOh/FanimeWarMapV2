//
//  HomePageViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/25/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainMenuTableView: UITableView!
    
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
//            navigationController?.popViewController(animated: true)
//            if let currentNavigationController = self.navigationController {
//                currentNavigationController.popToRootViewController(animated: true)
//            }
            break
        default:
            print("default case")
        }
    }
    
    
}
