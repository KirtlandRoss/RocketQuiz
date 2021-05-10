//
//  File.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/8/21.
//

import Foundation

protocol UserDelegate{
    var name : String { get }
    var password : String { get set }
    var quiz : Quiz { get set }

}
//stores and randomizes the questions
protocol QuestionBankDelegate{
    var questions : [Question] { get set }

    //function will create a random set of questions for the quiz
    func randomQuestions() -> [Question]


}
//stores a collection of questions, stores users answers, checks if they are correct
protocol QuizDelegate{
    var questions : [Question] { get set }
    var answers : [Answer?] { get set }
    var grade : Double? { get }

    //this should also check if answer is correct when storing the answer
    func submitAnswer (ans : Answer)

    //this will set grade
    func computeGrade()


}


// this is an Int64 as to allow easy Core Data integration
enum Answer : Int64 {
    case A = 1
    case B = 2
    case C = 3
    case D = 4
}
