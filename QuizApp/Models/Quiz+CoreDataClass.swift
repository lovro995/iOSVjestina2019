//
//  Quiz+CoreDataClass.swift
//  QuizApp
//
//  Created by Lovro Pejic on 13/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Quiz)
public class Quiz: NSManagedObject {

    
    class func firstOrCreate(withId id: Int32) -> Quiz? {
        
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let quizzes = try context.fetch(request)
            if let quiz = quizzes.first {
                // print("quiz postoji")
                return quiz
            } else {
                // print("novi quiz")
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
            
            if let quiz = Quiz.firstOrCreate(withId: Int32(id)) {
                
                quiz.id = Int32(id)
                quiz.title = title
                quiz.desc = description
                quiz.imageString = imageString
                quiz.category = categoryString
                quiz.level = Int32(level)
                
                for current in questionsJSON{
                    let question = Question.createFrom(json: current as! [String : Any])
                    quiz.addToQuestions(question!)
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
