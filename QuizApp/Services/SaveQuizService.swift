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
    func saveQuizResult(quizId: Int, correctAnswersNum : Int, time : Double, completion: @escaping((ServerResponse?)-> Void)){
        
        if let url = URL(string: urlString) {
            
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
            request.setValue(token!, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            let params : [String : Any] = [
                "quiz_id" : quizId as Int,
                "user_id" : Int(user_id!)! as Int,
                "time" : time as Double,
                "no_of_correct" : correctAnswersNum as Int
            ]
    
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
              
            } catch let error {
                print("error occured.")
                print(error.localizedDescription)
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("saving data in progress")
                if let httpResponse = response as? HTTPURLResponse {
                        print("statusCode: \(httpResponse.statusCode)")
            
                        completion(ServerResponse(code: httpResponse.statusCode))
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
