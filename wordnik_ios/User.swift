//
//  User.swift
//  wordnik_ios
//
//  Created by Damir Kazbekov on 5/2/17.
//  Copyright © 2017 damirkazbekov. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct User {
    var email: String = ""
    var password: String = ""
    
    init(email:String, password: String) {
        self.email = email
        self.password = password
    }
    init(snapshot: FIRDataSnapshot) {
        let value = snapshot.value as! NSDictionary
        email = value["email"] as! String
        password = value["password"] as! String
    }
    func toAnyObject() -> Any{
        return ["email":email,"password":password]
    }
    
}
