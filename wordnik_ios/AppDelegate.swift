//
//  AppDelegate.swift
//  wordnik_ios
//
//  Created by Damir Kazbekov on 5/2/17.
//  Copyright © 2017 damirkazbekov. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        
        UISearchBar.appearance().barTintColor = UIColor.blackwhite().withAlphaComponent(0.5)
        UISearchBar.appearance().tintColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.blackwhite()
        
        UINavigationBar.appearance().barTintColor =  UIColor.blackwhite()
        UINavigationBar.appearance().tintColor = .white
        
        // Override point for customization after application launch.
        return true
    }

}

extension UIColor {
    static func blackwhite() -> UIColor {
        return UIColor(red: 35.0/255.0, green: 40.0/255.0, blue: 53.0/255.0, alpha: 1.0)
    }
}

