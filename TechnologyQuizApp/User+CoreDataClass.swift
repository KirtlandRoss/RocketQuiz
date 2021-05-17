//
//  User+CoreDataClass.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/11/21.
//
//

import Foundation
import CoreData


// Conforms User to Comparable so we can use .sort() for average scores
// Source: https://developer.apple.com/documentation/swift/comparable 
extension User: Comparable
{
	public static func < (lhs: User, rhs: User) -> Bool
	{
		return lhs.averageScore < rhs.averageScore
	}
}

public class User: NSManagedObject
{

    func calculateScore() -> Double
	{
        let quizFetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Quiz")
        quizFetchReq.predicate = NSPredicate(format: "user.name == %@", self.name!)
        let quizes = try! self.managedObjectContext!.fetch(quizFetchReq) as! [Quiz]

        var scoreCounter = 0.0
        for item in quizes
		{
            print(quizes.count)
            print(item.grade)
            scoreCounter += item.grade
            print(scoreCounter)
        }

        self.averageScore = Double(scoreCounter) / (25*Double(quizes.count))
        return averageScore
    }
	
    func setupInvalidUser(){
        self.name = "invalid"
        self.firstName = "invalid"
        self.lastName = "invald"
        self.password = "invalid"
    }
}
