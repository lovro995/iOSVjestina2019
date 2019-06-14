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
    
    @IBOutlet weak var passwordTextView: UILabel!
    @IBOutlet weak var userNameTextView: UILabel!
    @IBOutlet weak var letsLoginTextView: UILabel!
    @IBOutlet weak var welcomeTextView: UILabel!
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
                    
                    self.saveUserData(userData : userData, userName : self.userNameTextField.text!)
                    
                    self.animateEverythingOut()
                    
                    /*
                     let vc = TabBarViewController()
                     
                     //self.dismiss(animated: true, completion: nil)
                     self.present(vc, animated: true, completion: nil)
                    */
                    
                }else{
                    self.cantLoginLabel.isHidden = false
                }
                
                self.loginBtn.isEnabled = true
            }
        }
    }
    func saveUserData(userData : UserData, userName : String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(userData.user_id, forKey: "user_id")
        userDefaults.set(userData.token, forKey: "token")
        userDefaults.set(userName, forKey: "username")
        
        print("user_id")
        print(userData.user_id)
        
        print("token")
        print(userData.token)
    }
    
    func animateEverythingOut() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.welcomeTextView.transform = CGAffineTransform(translationX: 0, y: -100)
            self.welcomeTextView.alpha = 0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.65, animations: {
            
            self.letsLoginTextView.transform = CGAffineTransform(translationX: 0, y: -100)
            self.letsLoginTextView.alpha = 0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.8, animations: {
            
            self.userNameTextField.transform = CGAffineTransform(translationX: 0, y: -100)
            self.userNameTextView.transform = CGAffineTransform(translationX: 0, y: -100)
            
            self.userNameTextField.alpha = 0
            self.userNameTextView.alpha = 0
            
        }) { _ in
        }
        
        
        UIView.animate(withDuration: 0.8, delay: 0.1, animations: {
            self.passwordTextField.transform = CGAffineTransform(translationX: 0, y: -100)
            self.passwordTextView.transform = CGAffineTransform(translationX: 0, y: -100)
            
              self.passwordTextField.alpha = 0
              self.passwordTextView.alpha = 0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.2, animations: {
            self.loginBtn.transform = CGAffineTransform(translationX: 0, y: -100)
            self.loginBtn.alpha = 0
            
            self.loginBackgroundView.alpha = 0
        }) { _ in
            
            let vc = TabBarViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func animateEverythingIn() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.welcomeTextView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.65, animations: {
            
            self.letsLoginTextView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.8, animations: {
            
            self.loginBackgroundView.alpha = 1
            
            self.userNameTextField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.userNameTextView.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }) { _ in
        }
        
        
        UIView.animate(withDuration: 0.8, delay: 0.1, animations: {
            self.passwordTextField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.passwordTextView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.2, animations: {
            self.loginBtn.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { _ in
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBackgroundView.layer.borderWidth = 2
        loginBackgroundView.layer.cornerRadius = 20
        
        self.userNameTextField.transform = CGAffineTransform(translationX: -130, y: 0)
        self.passwordTextField.transform = CGAffineTransform(translationX: -130, y: 0)
        self.userNameTextView.transform = CGAffineTransform(translationX: -130, y: 0)
        self.passwordTextView.transform = CGAffineTransform(translationX: -130, y: 0)
        self.loginBtn.transform = CGAffineTransform(translationX: -130, y: 0)
        
        self.letsLoginTextView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.welcomeTextView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        self.loginBackgroundView.alpha = 0
        
        animateEverythingIn()
    }
}
