//
//  ViewController.swift
//  wordnik_ios
//
//  Created by Damir Kazbekov on 5/2/17.
//  Copyright © 2017 damirkazbekov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user:FIRUser?,
            error:Error?) in
            if error == nil{
                self.performSegue(withIdentifier: "main", sender: nil)
            }else{
                print("Something happened")
            }
        })
    }

}

