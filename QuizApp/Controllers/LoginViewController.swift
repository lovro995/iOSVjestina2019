//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Lovro Pejic on 04/05/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var cantLoginLabel: UILabel!
    @IBOutlet weak var loginBackgroundView: UIView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func loginAction(_ sender: Any) {
        self.cantLoginLabel.isHidden = true
        self.loginBtn.isEnabled = false
        
        let loginService = LoginService()
        
        loginService.loginUser(userName: userNameTextField.text!, password: passwordTextField.text!){ (userData) in
            
             DispatchQueue.main.async {
                if let userData = userData{
                    
                    self.saveUserData(userData : userData)
                    
                    let vc = TabBarViewController()
                    
                    //self.dismiss(animated: true, completion: nil)
                    self.present(vc, animated: true, completion: nil)
                    
                }else{
                    self.cantLoginLabel.isHidden = false
                }
                
                self.loginBtn.isEnabled = true
            }
        }
    }
    func saveUserData(userData : UserData){
        let userDefaults = UserDefaults.standard
        userDefaults.set(userData.user_id, forKey: "user_id")
        userDefaults.set(userData.token, forKey: "token")
        
        print("user_id")
        print(userData.user_id)
        
        print("token")
        print(userData.token)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBackgroundView.layer.borderWidth = 2
        loginBackgroundView.layer.cornerRadius = 20
    }
}
