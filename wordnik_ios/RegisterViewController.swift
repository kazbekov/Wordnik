//
//  RegisterViewController.swift
//  wordnik_ios
//
//  Created by Damir Kazbekov on 5/2/17.
//  Copyright © 2017 damirkazbekov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    var dbRef: FIRDatabaseReference?
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference().child("users")

       
    }
    @IBAction func registerButtonPressed(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        let new_user = User(email: email, password: password)
        if (new_user.email.characters.count == 0 || new_user.password.characters.count == 0)
        {
            print("Empty field")
            
        } else{
            let userRef = self.dbRef?.child((password.lowercased()))
            userRef?.setValue(new_user.toAnyObject())
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                print ("User added")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
