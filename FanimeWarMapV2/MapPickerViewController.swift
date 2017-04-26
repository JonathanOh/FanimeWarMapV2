//
//  MapPickerViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/26/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit

protocol MapSelectedDelegate {
    func mapWasSelected(map: Map)
}

class MapPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate : MapSelectedDelegate? = nil
    var numberOfTeamsOnMapDict: [String : Int]? = nil
    
    let currentMaps : [Map] = [.WholeMap, .UpperLevelMap, .LowerLevelMap]
    @IBOutlet weak var mapPickerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapPickerTableView.delegate = self
        mapPickerTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "mapPickerCellID")
        cell = UITableViewCell(style: .default, reuseIdentifier: "mapPickerCellID")
        let teamName = currentMaps[indexPath.row].rawValue
        cell?.textLabel?.text = "\(teamName) (\(numberOfTeamsOnMapDict?[teamName] != nil ? numberOfTeamsOnMapDict![teamName]! : 0))"
        return cell!
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMaps.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            let SelectedMap = currentMaps[indexPath.row]
            delegate?.mapWasSelected(map: SelectedMap)
            navigationController!.popViewController(animated: true)
        }
    }
    
}
