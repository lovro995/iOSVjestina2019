//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Lovro Pejic on 11/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults.standard
        let userName = userDefaults.string(forKey: "username")
        userNameLabel.text = userName
        
    }
    
    @IBAction func LogoutUser(_ sender: Any) {
        deleteUserData()
        
        let vc = LoginViewController()
        //self.dismiss(animated: true, completion: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    func deleteUserData(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: "user_id")
        userDefaults.set(nil, forKey: "token")
        userDefaults.set(nil, forKey: "username")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
