//
//  EditTeamViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 5/18/17.
//  Copyright © 2017 Jonathan Oh. All rights reserved.
//

import UIKit

protocol MapValueWasEditedDelegate {
    func mapWasSelected(map: Map)
}

class EditTeamViewController: UIViewController, UITextFieldDelegate {

    private var mapPicker: UISegmentedControl?
    var teamBeingEdited: Team?
    var delegate: MapValueWasEditedDelegate?
    private var textFields = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        setupBackButton()
        setupSaveButton()
        guard let team = teamBeingEdited else { return }
        setupTitleWithTeam(name: team.teamLabelName)
        
        let memberCount: Int = team.doesTeamHaveNoMembers() ? 0 : team.teamMembers.count
        
        for x in 1...5 {
            if x == 1 {
                let teamNameField = createLabelWith(text: "Team Name: \(team.teamLabelName)", position: CGFloat(x))
                textFields.append(teamNameField)
                continue
            }
            if memberCount > x-2 {
                let memberNameField = createLabelWith(text: team.teamMembers[x-2], position: CGFloat(x))
                textFields.append(memberNameField)
            } else {
                let memberNameField = createLabelWith(text: "Name \(x-1)", position: CGFloat(x))
                textFields.append(memberNameField)
            }
        }
        mapPicker = createSegmentedControlForMaps(team: teamBeingEdited)
        
    }

    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupBackButton() {
        let dismissViewButton: UIButton = UIButton(type: .system)
        dismissViewButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        dismissViewButton.backgroundColor = UIColor.black
        dismissViewButton.setTitle("Back", for: .normal)
        self.view.addSubview(dismissViewButton)
        dismissViewButton.translatesAutoresizingMaskIntoConstraints = false
        
        dismissViewButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        dismissViewButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        dismissViewButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        dismissViewButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupSaveButton() {
        let saveButton: UIButton = UIButton(type: .system)
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        saveButton.backgroundColor = UIColor.white
        saveButton.setTitle("Save", for: .normal)
        self.view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func didTapSave(){
        guard let team = teamBeingEdited else {
            self.dismissView()
            return
        }
        var newMembers = [String]()
        for (index, textField) in textFields.enumerated() {
            guard let textValue = textField.text else { continue }
            if textValue == "" { continue }
            if index == 0 {
                team.updateTeamLabel(name: textValue)
            } else {
                newMembers.append(textValue)
            }
        }
        if newMembers.count > 0 {
            team.updateTeamMembers(members: newMembers)
        }
        if let map = mapPicker {
            guard let selectedMapString: String = map.titleForSegment(at: map.selectedSegmentIndex) else { return }
            guard let selectedMap: Map = Utils.getMapEnumFromString(name: selectedMapString) else { return }
            if selectedMap == team.assignedOnMap! {
                self.dismissView()
                return
            }
            team.teamIconView?.removeFromSuperview()
            team.teamWasDeployed(map: selectedMap)
            delegate?.mapWasSelected(map: selectedMap)
        }
        
        self.dismissView()
    }
    
    func setupTitleWithTeam(name: String) {
        let title: UILabel = UILabel()
        title.text = "Edit Team: \(name)"
        title.backgroundColor = UIColor.black
        title.textAlignment = .center
        title.textColor = UIColor.white
        title.font = UIFont(name: "Helvetica Neue", size: 25.0)
        self.view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.topAnchor.constraint(equalTo: view.topAnchor, constant: 30.0).isActive = true
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        title.widthAnchor.constraint(equalToConstant: 500.0).isActive = true
        title.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }

    func createLabelWith(text: String, position: CGFloat) -> UITextField {
        let label: UITextField = UITextField()
        label.placeholder = text
        label.textAlignment = .center
        label.delegate = self
        label.borderStyle = .roundedRect
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100 + position * 40).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        label.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        return label
    }
    
    func createSegmentedControlForMaps(team: Team?) -> UISegmentedControl? {
        guard let currentTeam = team else { return nil }
        
        let maps: [String] = [Map.WholeMap.rawValue, Map.UpperLevelMap.rawValue, Map.LowerLevelMap.rawValue, Map.FairmontMap.rawValue, Map.MarriottMap.rawValue, Map.HiltonMap.rawValue]
        let control = UISegmentedControl(items: maps)
        
        guard let currentTeamMap = currentTeam.assignedOnMap else { return nil }
        switch currentTeamMap {
            case Map.WholeMap:
                control.selectedSegmentIndex = 0
            case Map.UpperLevelMap:
                control.selectedSegmentIndex = 1
            case Map.LowerLevelMap:
                control.selectedSegmentIndex = 2
            case Map.FairmontMap:
                control.selectedSegmentIndex = 3
            case Map.MarriottMap:
                control.selectedSegmentIndex = 4
            case Map.HiltonMap:
                control.selectedSegmentIndex = 5
        }
        control.addTarget(self, action: #selector(mapSegmentSelected), for: .valueChanged)
        self.view.addSubview(control)
        control.translatesAutoresizingMaskIntoConstraints = false
        
        control.topAnchor.constraint(equalTo: textFields[textFields.endIndex - 1].bottomAnchor, constant: 10).isActive = true
        control.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        control.widthAnchor.constraint(equalToConstant: 600.0).isActive = true
        control.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        return control
    }
    
    func mapSegmentSelected() {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}



