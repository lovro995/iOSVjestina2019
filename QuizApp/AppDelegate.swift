//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Lovro Pejic on 06/04/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //let vc = InitialViewController()
        
        let userDefaults = UserDefaults.standard
        
        let user_id = userDefaults.string(forKey: "user_id")
        
        var vc: UIViewController
        
        if(user_id == nil){
            print("user is not logged in")
            vc = LoginViewController()
        } else{
            print("user is logged in")
            vc = InitialViewController()
        }
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }

}

