//
//  User+CoreDataProperties.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/9/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var quiz: Quiz?

}

extension User : Identifiable {

}
