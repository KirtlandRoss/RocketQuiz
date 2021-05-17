//
//  QuizHandler.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/16/21.
//

import Foundation

class QuizHandler{
    var correctAnswers : [Bool]

    init(){
        correctAnswers = [Bool]()
        for _ in 1...25{
            correctAnswers.append(false)
        }

    }

    func updateScore(_ i : Int){
        correctAnswers[i] = true
    }

}
