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

    func createQuizQuestion (_ num : Int,_ bankedQuest: BankedQuestion){
        correctAnswer = bankQuestion!.correctAnswer
        incorrectAnswers = bankQuestion!.incorrectAnswers
        question = bankQuestion!.question
        number = Int64(num)
        
        self.bankQuestion = bankedQuest
    }
}
