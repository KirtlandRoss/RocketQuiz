//
//  Quiz+CoreDataClass.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/11/21.
//
//

import Foundation
import CoreData


public class Quiz: NSManagedObject {


    func setQuizQuestions (_ bankQuests : [BankedQuestion]){
        var arr = bankQuests
        arr.shuffle()
        for (n, v) in arr.enumerated(){
            let quizQuestion = QuizQuestion(context: self.managedObjectContext!)
            quizQuestion.createQuizQuestion(n,v)
            quizQuestion.quiz = self
            self.addToQuestions(quizQuestion)

        }


    }
    func calculateGrade(){
        var numCorrect = 0
        for item in questions?.array as! [QuizQuestion]{
            if item.answeredCorrect{
                numCorrect += 1
            }
        }
        grade = Double(numCorrect / 25)
    }

}
