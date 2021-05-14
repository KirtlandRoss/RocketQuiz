//
//  User+CoreDataClass.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/11/21.
//
//

import Foundation
import CoreData


public class User: NSManagedObject{
    func setupInvalidUser(){
        self.name = "invalid"
        self.firstName = "invalid"
        self.lastName = "invald"
        self.password = "invalid"
    }
}
