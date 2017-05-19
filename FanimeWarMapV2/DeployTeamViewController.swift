//
//  DeployTeamViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/30/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit

protocol SelectedTeamToDeployDelegate {
    func teamWasSelectedToDeploy(team: Team, map: Map)
}

class DeployTeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var deployableTeamsTableView: UITableView!
    var currentMapBeingDeployedTo : Map?
    var deployableTeams : [Team]? = nil
    var delegate : SelectedTeamToDeployDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Deploy Team to Map"
        
        deployableTeamsTableView.delegate = self
        deployableTeamsTableView.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "teamCellId") as? ViewTeamsPrototypeCell else {
            return ViewTeamsPrototypeCell()
        }
        guard let availableTeams = deployableTeams else {
            return ViewTeamsPrototypeCell()
        }
        guard let teamIcon = availableTeams[indexPath.row].teamIcon else {
            return ViewTeamsPrototypeCell()
        }
        
        cell.configureCell(icon: teamIcon, name: availableTeams[indexPath.row].teamLabelName, members: [""])
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let length = deployableTeams?.count {
            return length
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let teamToPass = deployableTeams?[indexPath.row] else { return }
        guard let currentMap = currentMapBeingDeployedTo else { return }
        delegate?.teamWasSelectedToDeploy(team: teamToPass, map: currentMap)
        navigationController!.popViewController(animated: true)
    }
    
}
