//
//  Question+CoreDataProperties.swift
//  QuizApp
//
//  Created by Lovro Pejic on 12/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answers: [String]?
    @NSManaged public var correct_answer: Int32
    @NSManaged public var question: String?
    @NSManaged public var id: Int32

}
