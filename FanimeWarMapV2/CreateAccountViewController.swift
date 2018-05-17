//
//  CreateAccountViewController.swift
//  FanimeWarMapV2
//
//  Created by Jonathan Oh on 12/10/16.
//  Copyright © 2016 Jonathan Oh. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func createAccountButton(_ sender: Any) {
        
        guard let email = emailTextField.text else { return } //Returns if nil email
        guard let password = passwordTextField.text else { return } //Returns if nil password
        
        if email.count < 1 { return }
        if password.count < 1 { return }
        
        AuthService.sharedInstance.createAccountWith(email: email, password: password, onComplete: { (error: String?, user: AnyObject?) -> Void in
            guard let userId = user?.uid else { return }
            DataService.sharedIntances.saveUser(uid: userId, email: email)
            self.dismiss(animated: true, completion: nil)
            // Show error alerts if we get issue with account creation
            // We need to pass error and data in here from AuthService
            // once we get a user, we must store their UID in to firebase to make that connection between this authenticated user and an existing user
        })
        
    }
}
