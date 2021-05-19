//
//  QuizHandler.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/16/21.
//

import Foundation
import CoreData

class QuizHandler{
    var correctAnswers : [Bool]
    var answerDict = [Int : [String]]()
    init(){
        correctAnswers = [Bool]()
        for _ in 1...25{
            correctAnswers.append(false)
        }
    }
    func updateScore(_ i : Int){
        correctAnswers[i] = true
    }
    func generateShuffledAnswers(_ username : String, _ context: NSManagedObjectContext) {

        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let userFetchPred = NSPredicate(format: "name == %@", username)
        print(username)
        userFetch.predicate = userFetchPred
        var user = try! context.fetch(userFetch).first as! User
//        print(user)
//        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Quiz")
//        let adminPredicate = NSPredicate(format: " == %@", user.name!)
//        fetchReq.predicate = adminPredicate
        var quiz = user.quizes?.lastObject as! Quiz


        for quest in quiz.questions?.array as! [QuizQuestion]{
            var ansArr = [quest.correctAnswer!, quest.incorrectAnswers![0], quest.incorrectAnswers![1], quest.incorrectAnswers![2]]
            ansArr.shuffle()
            answerDict[Int(quest.number)] = ansArr
        }
    }

}
