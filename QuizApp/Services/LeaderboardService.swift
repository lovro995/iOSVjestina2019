//
//  LeaderboardService.swift
//  QuizApp
//
//  Created by Lovro Pejic on 11/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardService{
    
       /*
        print("leaderboard........")
        
        let finalString = urlString + String(quizId)
        print(finalString)
        
        if let url = URL(string: finalString) {
            let userDefaults = UserDefaults.standard
            let token = userDefaults.string(forKey: "token")
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue(token!, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print("leaderboard fetched........")
                        print(json)
                        
                        completion(nil)
                    } catch {
                        completion(nil)
                    }
                    
                } else {
                    completion(nil)
                }
            }
            print("pokrecem dataTask...")
            dataTask.resume()
        } else {
            print("pokrecem fail..")
            completion(nil)
        }
        */
        
        var urlString = "https://iosquiz.herokuapp.com/api/score?quiz_id="
        
    func fetchLeaderboard(quizId : Int, completion: @escaping ((LeaderboardDataList?) -> Void)) {
        
         let finalString = urlString + String(quizId)
        
            if let url = URL(string: finalString) {
                let userDefaults = UserDefaults.standard
                let token = userDefaults.string(forKey: "token")
                
                var request = URLRequest(url: url)
                
                request.setValue(token!, forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let data = data {
                        
                        do {
                            
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            //let quizzes = Quizzes(json: json)
                            
                            let leaderboardDataList = LeaderboardDataList(json: json)
                            
                            //print(json)
                            completion(leaderboardDataList)
                        } catch {
                            completion(nil)
                        }
                        
                    } else {
                        completion(nil)
                    }
                }
                print("pokrecem dataTask leaderboard...")
                dataTask.resume()
            } else {
                print("pokrecedasfam dataTask...")
                completion(nil)
            }
            
        }

}
