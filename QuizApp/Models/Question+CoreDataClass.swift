//
//  Question+CoreDataClass.swift
//  QuizApp
//
//  Created by Lovro Pejic on 12/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Question)
public class Question: NSManagedObject {
    class func firstOrCreate(withId id: Int32) -> Question? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let questions = try context.fetch(request)
            if let question = questions.first {
                print("question postoji")
                return question
            } else {
                print("novi question")
                let newQuestion = Question(context: context)
                return newQuestion
            }
        } catch {
            return nil
        }
    }
    
    
    class func createFrom(json: [String: Any]) -> Question? {
        if
            
            let id = json["id"] as? Int,
            let questionText = json["question"] as? String,
            let correct_answer = json["correct_answer"] as? Int,
            let answers = json["answers"] as? [String] {
            
            if let question = Question.firstOrCreate(withId: Int32(id)) {
                
                question.id = Int32(id)
                question.question = questionText
                question.correct_answer = Int32(correct_answer)
                question.answers = answers
                
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return question
                } catch {
                    print("Failed saving question")
                }
            }
        }
        return nil
    }
}
