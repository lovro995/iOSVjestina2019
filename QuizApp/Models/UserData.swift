//
//  UserData.swift
//  QuizApp
//
//  Created by Lovro Pejic on 04/05/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation

class UserData{
    let token : String
    let user_id : Int
    
    init?(json: Any) {
        
        if let jsonDict = json as? [String: Any],
            
            let token = jsonDict["token"] as? String,
            let user_id = jsonDict["user_id"] as? Int{
            
            self.token = token
            self.user_id = user_id
            
        } else {
            return nil
        }
    }
}
