//
//  ViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 11/25/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit
import Firebase
import TinyConstraints

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    let adminUsername : String = "cool"
    let adminPassword : String = "guy"
    
    override func loadView() {
        super.loadView()
        let bgImage = UIImage(imageLiteralResourceName: "fanime2018image")
        let bgImageView = UIImageView(image: bgImage)
        bgImageView.contentMode = .scaleAspectFit
        view.addSubview(bgImageView)
        bgImageView.edgesToSuperview()
        view.sendSubview(toBack: bgImageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        usernameTextField.text = ""
        passwordTextField.text = ""
        
        setupButtonStyle()
    }
    
    func setupButtonStyle() {
        [loginButton, createAccountButton].forEach { button in
            button?.backgroundColor = .white
            button?.layer.cornerRadius = 10
            button?.layer.borderColor = UIColor(red: 0.196, green: 0.3098, blue: 0.52, alpha: 1).cgColor//Red:.196 green:0.3098 blue:0.52 //UIColor.black.cgColor
            button?.layer.borderWidth = 2
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        
        //guard adminUsername == usernameTextField.text! && adminPassword == passwordTextField.text! else { return }
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        
        
        //usernameTextField.text = ""
        //passwordTextField.text = ""
        AuthService.sharedInstance.loginWith(email: username, password: password, onComplete: { [weak self] (error: String?, authDataResult: AuthDataResult?) in
            guard let unwrappedSelf = self else { return }
            guard let authDataResult = authDataResult else {
                let alert = Utils.customWhoopsAlert(message: "Login Failed")
                unwrappedSelf.present(alert, animated: true, completion: nil)
                return
            }
            // we have a user logged in successfully
            DataService.sharedIntances.userLoggedIn(uid: authDataResult.user.uid)
            unwrappedSelf.passwordTextField.text = ""
            unwrappedSelf.performSegue(withIdentifier: "loginToHomeSegue", sender: self)
        })
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        
        performSegue(withIdentifier: SegueId.createAccountId, sender: self)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}

