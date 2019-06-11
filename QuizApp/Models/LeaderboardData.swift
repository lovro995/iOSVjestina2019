//
//  LeaderboardData.swift
//  QuizApp
//
//  Created by Lovro Pejic on 11/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation

class LeaderboardData {
    let userName : String
    let score: String
    
    init?(json: Any) {
        
        if let jsonDict = json as? [String: Any],
            
            let userName = jsonDict["username"] as? String,
            let score = jsonDict["score"] as? String {
               
            self.userName = userName
            self.score = score
        } else {
            return nil
        }
    }
}
