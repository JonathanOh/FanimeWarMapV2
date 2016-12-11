//
//  ViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/25/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    let adminUsername : String = "cool"
    let adminPassword : String = "guy"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.text = "cool"
        passwordTextField.text = "guy"
        
    }

    @IBAction func loginButton(_ sender: Any) {
        
        guard adminUsername == usernameTextField.text! && adminPassword == passwordTextField.text! else {
            return
        }
        
        //usernameTextField.text = ""
        //passwordTextField.text = ""
        
        performSegue(withIdentifier: "loginToHomeSegue", sender: self)
        
        
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        
        performSegue(withIdentifier: SegueId.createAccountId, sender: self)
        
    }


}

