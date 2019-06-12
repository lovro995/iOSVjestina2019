//
//  Quiz+CoreDataClass.swift
//  QuizApp
//
//  Created by Lovro Pejic on 12/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Quiz)
public class Quiz: NSManagedObject {
    
    class func firstOrCreate(withId id: Int32) -> Quiz? {
         print("prosao 3")
        let context = DataController.shared.persistentContainer.viewContext
         print("prosao 4")
        
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
         print("prosao 5")
        request.predicate = NSPredicate(format: "id = %i", id)
         print("prosao 6")
        request.returnsObjectsAsFaults = false
         print("prosao 7")
        
        do {
            let quizzes = try context.fetch(request)
            if let quiz = quizzes.first {
                print("quiz postoji")
                return quiz
            } else {
                print("novi quiz")
                let newReview = Quiz(context: context)
                return newReview
            }
        } catch {
            return nil
        }
    }
    
    
    class func createFrom(json: [String: Any]) -> Quiz? {
        if
            let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let imageString = json["image"] as? String,
            let categoryString = json["category"] as? String,
            let level = json["level"] as? Int,
            let questionsJSON = json["questions"] as? [Any] {
            
            print("prosao 1")
            
            if let quiz = Quiz.firstOrCreate(withId: Int32(id)) {
                 print("prosao 2")
                quiz.id = Int32(id)
                quiz.title = title
                quiz.desc = description
                quiz.imageString = imageString
                quiz.category = categoryString
                quiz.level = Int32(level)
                
                
                 print("prije for")
                for current in questionsJSON{
                     print("for 1")
                    let question = Question.createFrom(json: current as! [String : Any])
                     print("for 2")
                    quiz.addToQuestions(question!)
                     print("for 3")
                }
                
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return quiz
                } catch {
                    print("Failed saving quiz")
                }
            }
        }
        return nil
    }
}
