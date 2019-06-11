//
//  LeaderboardDataList.swift
//  QuizApp
//
//  Created by Lovro Pejic on 11/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation

class LeaderboardDataList{
    var leaderboardDataList: [LeaderboardData] = []
    
    // failable konstruktor koji prima json
    init?(json: Any) {
        
        if let leaderboardDataListjson = json as? [Any] { // za kljuc "borders" dohvatimo
           
            for current in leaderboardDataListjson{
                
                let leaderboardData = LeaderboardData(json:current)
                self.leaderboardDataList.append(leaderboardData!)
            }
            
        } else {
           
            print("pogreska....................")
            return nil
        }
        
    }
    
    
}
