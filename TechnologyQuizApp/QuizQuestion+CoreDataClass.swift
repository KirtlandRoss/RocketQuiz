//
//  QuizQuestion+CoreDataClass.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/16/21.
//
//

import Foundation
import CoreData

@objc(QuizQuestion)
public class QuizQuestion: NSManagedObject {

    func createQuizQuestion (_ num : Int,_ bq: BankedQuestion){
        correctAnswer = bq.correctAnswer
        incorrectAnswers = bq.incorrectAnswers
        question = bq.question
        number = Int64(num)
        
        self.bankQuestion = bq
    }
}
