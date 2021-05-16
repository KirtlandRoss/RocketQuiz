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
            print("setQuizQuestions:")
            print(n, v)
            let quizQuestion = QuizQuestion(context: self.managedObjectContext!)
            quizQuestion.createQuizQuestion(n,v)
            quizQuestion.quiz = self
            self.addToQuestions(quizQuestion)

        }

    }

}
