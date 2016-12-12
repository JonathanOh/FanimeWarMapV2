//
//  ViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/25/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    let adminUsername : String = "cool"
    let adminPassword : String = "guy"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.text = "qwertytest@gmail.com"
        passwordTextField.text = "123456"
        
    }

    @IBAction func loginButton(_ sender: Any) {
        
        //guard adminUsername == usernameTextField.text! && adminPassword == passwordTextField.text! else { return }
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        
        
        //usernameTextField.text = ""
        //passwordTextField.text = ""
        AuthService.sharedInstance.loginWith(email: username, password: password, onComplete: { (error: String?, user: AnyObject?) in
            guard let user = user as? FIRUser else {
                let alert = Utils.customWhoopsAlert(message: "Login Failed")
                self.present(alert, animated: true, completion: nil)
                return
            }
            // we have a user logged in successfully
            DataService.sharedIntances.userLoggedIn(uid: user.uid)
            self.performSegue(withIdentifier: "loginToHomeSegue", sender: self)
        })
        
        
        
        
        
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        
        performSegue(withIdentifier: SegueId.createAccountId, sender: self)
        
    }


}

