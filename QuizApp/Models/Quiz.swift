//
//  QuizModel.swift
//  QuizApp
//
//  Created by Lovro Pejic on 06/04/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation

class Quiz {
    let title: String
    let category: Category
    let imageString : String?
    var questions : [Question] = []
    
    init?(json: Any) {
        //print("++++++++++++++ start")
        //print(json)
        //print("xxxxxxxxxxxxxx stop")
        
        if let jsonDict = json as? [String: Any],
            
            let title = jsonDict["title"] as? String,
            
            let imageString = jsonDict["image"] as? String,
            let categoryString = jsonDict["category"] as? String,
            let questionsJSON = jsonDict["questions"] as? [Any] {
            
            self.title = title
            self.category = Category(categoryString: categoryString)!
            self.imageString = imageString
            
            for current in questionsJSON{
                let question = Question(json:current)
                self.questions.append(question!)
            }
            
            
            //print("Slika je na \(self.imageString!)")
            //print("napravio QUIZ..........")
        } else {
            return nil
        }
    }
}
