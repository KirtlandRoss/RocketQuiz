//
//  Quiz+CoreDataProperties.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/11/21.
//
//

import Foundation
import CoreData


extension Quiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quiz> {
        return NSFetchRequest<Quiz>(entityName: "Quiz")
    }

    @NSManaged public var answers: [Int64]?
    @NSManaged public var grade: Double
    @NSManaged public var questions: Question?
    @NSManaged public var user: User?

}

extension Quiz : Identifiable {

}
