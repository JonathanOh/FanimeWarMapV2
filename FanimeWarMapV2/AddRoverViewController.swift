//
//  AddRoverViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/27/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit

protocol RoverAddedDelegate {
    func roverWasAdded(rover: Rover)
}

class AddRoverViewController: UIViewController, UITextFieldDelegate {
    
    var delegate : RoverAddedDelegate? = nil

    @IBOutlet weak var roverNameTextField: UITextField!
    @IBOutlet weak var roverPhoneTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roverNameTextField.delegate = self
        roverPhoneTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func addRoverButton(_ sender: Any) {
        
        guard let roverName = roverNameTextField.text else {
            return
        }
        guard let roverPhone = roverPhoneTextField.text else {
            return
        }
        
        if roverName.characters.count < 1 {
            return
        }
        
        if roverPhone.characters.count != 10 && roverPhone.characters.count != 0 {
            return
        }
        
        let newRover = Rover(name: roverName, phone: roverPhone, team: nil)
        
        if delegate != nil {
            delegate?.roverWasAdded(rover: newRover)
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
