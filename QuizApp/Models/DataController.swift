//
//  DataController.swift
//  QuizApp
//
//  Created by Lovro Pejic on 12/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation
import CoreData

class DataController{
    static let shared = DataController()
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func fetchAllQuizzes() -> [Quiz]? {
    
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
    
        let context = DataController.shared.persistentContainer.viewContext
        
        let quizzes = try? context.fetch(request)
        return quizzes
    }
    
    
    func saveContext () {
        
        // viewContext je NSManagedObjectContext objekt iz kojeg dohvacamo, u kojem stvaramo, brisemo ili mijenjamo objekte na main thread-u
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
}


