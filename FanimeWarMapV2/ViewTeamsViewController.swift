//
//  ViewTeamsViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/26/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit

class ViewTeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var currentTeamsTableView: UITableView!
    
    var currentTeams : [Team]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTeamsTableView.delegate = self
        currentTeamsTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

// MARK: Table view delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "teamCellId")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "teamCellId")
        
        guard let currentTeam = currentTeams else {
            return UITableViewCell()
        }
        
        let team : Team = currentTeam[indexPath.row]
        cell?.textLabel?.text = team.teamName
        cell?.detailTextLabel?.text = team.teamIcon
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTeams!.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}