//
//  LoginService.swift
//  QuizApp
//
//  Created by Lovro Pejic on 04/05/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation
import UIKit

class SaveQuizService{
    
    var urlString = "https://iosquiz.herokuapp.com/api/result"
    func saveQuizResult(quizId: Int, correctAnswersNum : Int, time : Double, completion: @escaping((UserData?)-> Void)){
        
        // ovdje stvaramo URL objekt kojeg mozemo stvoriti iz nekog stringa koji je url
        // ako string nije url onda ovaj failable konstruktor vraca nil
        
        print("1xxxx")
        if let url = URL(string: urlString) {
            
            print("2xxxx")
            
            
            let userDefaults = UserDefaults.standard
            let user_id = userDefaults.string(forKey: "user_id")
            let token = userDefaults.string(forKey: "token")
            
            print("user_id to send")
            print(user_id!)
            
            print("token to send")
            print(token!)
            // URLRequest objekt stvaramo iz URL objekta
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(token!, forHTTPHeaderField: "Authorization")
            
            let params : [String : Any] = [
                "quiz_id" : quizId,
                "user_id" : user_id!,
                "time" : time,
                "no_of_correct" : correctAnswersNum
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                
                print("error occured.")
                print(error.localizedDescription)
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("saving data in progress")
                if let data = data {
                   
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options:[])
                        
                        print("data is: ")
                        print(json)
                        
                        let toReturn : [String : Any] = ["user_id" : user_id!,
                                                         "token" : token!]
                        
                        completion(UserData(json: toReturn)
                        )
                        
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
