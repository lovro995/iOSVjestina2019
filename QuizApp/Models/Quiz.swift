//
//  QuizModel.swift
//  QuizApp
//
//  Created by Lovro Pejic on 06/04/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//
/*
import Foundation

class Quiz {
    let id : Int
    let title: String
    let category: Category
    let description : String
    let imageString : String?
    let level : Int
    var questions : [Question] = []
    
    init?(json: Any) {
        //print("++++++++++++++ start")
        //print(json)
        //print("xxxxxxxxxxxxxx stop")
        
        if let jsonDict = json as? [String: Any],
            
            let id = jsonDict["id"] as? Int,
            let title = jsonDict["title"] as? String,
            let description = jsonDict["description"] as? String,
            let imageString = jsonDict["image"] as? String,
            let categoryString = jsonDict["category"] as? String,
            let level = jsonDict["level"] as? Int,
            let questionsJSON = jsonDict["questions"] as? [Any] {
            
            self.id = id
            self.level = level
            self.title = title
            self.category = Category(categoryString: categoryString)!
            self.description = description
            self.imageString = imageString
            
            for current in questionsJSON{
                let question = Question(json:current)
                self.questions.append(question!)
            }
            
        } else {
            return nil
        }
    }
}*/
