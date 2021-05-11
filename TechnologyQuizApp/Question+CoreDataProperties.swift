//
//  Question+CoreDataProperties.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/11/21.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answer: Int64
    @NSManaged public var question: String?
    @NSManaged public var questionBank: QuestionBank?

}

extension Question : Identifiable {

}
