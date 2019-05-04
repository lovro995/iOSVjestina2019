//
//  LoginService.swift
//  QuizApp
//
//  Created by Lovro Pejic on 04/05/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation
import UIKit

class LoginService{
    
    var urlString = "https://iosquiz.herokuapp.com/api/session"
    func loginUser(userName: String, password : String, completion: @escaping((UserData?)-> Void)){

        // ovdje stvaramo URL objekt kojeg mozemo stvoriti iz nekog stringa koji je url
        // ako string nije url onda ovaj failable konstruktor vraca nil
        if let url = URL(string: urlString) {
            
            // URLRequest objekt stvaramo iz URL objekta
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let params : [String : Any] = [
                "username" : userName,
                "password" : password
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
                    
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    print("login user in progress")
                if let data = data {
                    //let image = UIImage(data: data)
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options:[])
                       
                        print("data is: ")
                        print(json)
                        
                        let userData = UserData(json: json)
                        completion(userData)
                        
                    } catch {
                        completion(nil)
                    }
                    
                } else {
                    completion(nil)
                }
            }
                    // kraj stvaranja dataTask-a
            print("resuming data task")
            // Pokretanje dataTask-a, dohvacanje URL-a
            dataTask.resume()
            } else {
                completion(nil)
            }
    }

}
