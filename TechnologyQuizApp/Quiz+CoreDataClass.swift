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
        for question in bankQuests.enumerated(){
            let quizQuestion = QuizQuestion(context: self.managedObjectContext!)
            quizQuestion.createQuizQuestion(question.1)
            self.addToQuestions(quizQuestion)

        }

    }

}
