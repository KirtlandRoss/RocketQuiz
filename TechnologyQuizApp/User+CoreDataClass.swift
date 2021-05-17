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

    func calculateScore() -> Double{
        var scoreCounter = 0.0
        for item in quizes?.array as! [Quiz]{
            print(item.grade)
            scoreCounter += item.grade
        }

        self.averageScore = scoreCounter / Double(25 * quizes!.count)
        return averageScore
    }
    func setupInvalidUser(){
        self.name = "invalid"
        self.firstName = "invalid"
        self.lastName = "invald"
        self.password = "invalid"
    }
}
