//
//  Quizzes.swift
//  QuizApp
//
//  Created by Lovro Pejic on 06/04/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation

class Quizzes {
    var quizzes: [Quiz] = []
    
    // failable konstruktor koji prima json
    init?(json: Any) {
        print("-------------")
        print(json)
        if let jsonDict = json as? [String: Any],
            let quizzesJSON = jsonDict["quizzes"] as? [Any] { // za kljuc "borders" dohvatimo
         
            for current in quizzesJSON{
                let quiz = Quiz(json:current)
                self.quizzes.append(quiz!)
            }
            
          /*  var res:String = "ukupno \(String(count))"
            print("\(res)")*/
            
        } else {
            // u slucaju da je nesto poslo krivo, nekakav kljuc je drugaciji ili je tip kriv, vratimo nil
            print("pogreska.....")
            return nil
        }
        
    }
    
}
