//
//  QuestionBank+CoreDataClass.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/11/21.
//
//

import Foundation
import CoreData
import UIKit


public class QuestionBank: NSManagedObject
{





	func addQ()
	{


		// Hard code the questions from the spreadsheet into the bank
		var qList = [BankedQuestion]()
        let context = SceneDelegate().context!
		for _ in 0..<25
		{
            let quest = BankedQuestion(context: context)
            quest.question = ""
            quest.correctAnswer = ""
            quest.incorrectAnswers = ["wrongA","wrongB","wrongC"]
            quest.questionBank = self
			qList.append(quest)

		}
		qList[0].question = "What company developed Swift?"
		qList[1].question = "What is a protocol?"
		qList[2].question = "What language did Swift replace in development for Apple platforms?"
		qList[3].question = "Who originally led the development of Swift?"
		qList[4].question = "When was Swift first released?"

		qList[0].correctAnswer = "Apple"
		qList[1].correctAnswer = "A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality."
		qList[2].correctAnswer = "Objective-C"
		qList[3].correctAnswer = "Chris Lattner"
		qList[4].correctAnswer = "2014"


		qList[5].question = "What is Github?"
		qList[6].question = "What is open-source software?"
		qList[7].question = "What method is used to create a separate copy of a repository?"
		qList[8].question = "What non-code file is recommended for every project?"
		qList[9].question = "What starts the branch merge process?"

		qList[5].correctAnswer = "Version/Source control service"
		qList[6].correctAnswer = "Software released under a license that permits users to study, change, and redistribute it"
		qList[7].correctAnswer = "Fork"
		qList[8].correctAnswer = "README"
		qList[9].correctAnswer = "Pull request"

		qList[10].question = "Who invented C++?"
		qList[11].question = "What two statements are used in error handling with C++?"
		qList[12].question = "What keyword is used to import libraries?"
		qList[13].question = "What library is used for basic printing and typing to the console?"
		qList[14].question = "What year was C++ first released?"

		qList[10].correctAnswer = "Bjarne Stroustrup"
		qList[11].correctAnswer = "Try and Catch"
		qList[12].correctAnswer = "#include"
		qList[13].correctAnswer = "iostream"
		qList[14].correctAnswer = "1985"

		qList[15].question = "What paradigm does Java use?"
		qList[16].question = "What company owns and develops Java?"
		qList[17].question = "What keywords are used for access control?"
		qList[18].question = "Who first developed Java?"
		qList[19].question = "What mobile platform uses Java?"

		qList[15].correctAnswer = "Object-Oriented Programming"
		qList[16].correctAnswer = "Oracle"
		qList[17].correctAnswer = "Private, Public, Protected"
		qList[18].correctAnswer = "James Gosling"
		qList[19].correctAnswer = "Android"

		qList[20].question = "What is a GPU?"
		qList[21].question = "What part do all others connect to?"
		qList[22].question = "What type of cable is used to connect storage devices?"
		qList[23].question = "What part handles interpretation and execution of programs?"
		qList[24].question = "What is one PC part that isn't required for any build?"

		qList[20].correctAnswer = "Graphics Processing Unit"
		qList[21].correctAnswer = "The motherboard"
		qList[22].correctAnswer = "SATA"
		qList[23].correctAnswer = "Central Processing Unit"
		qList[24].correctAnswer = "Tower case"

		for item in qList
		{
            print(item)

            self.addToQuestions(item)
        }


	}

    func addQ(newQ : BankedQuestion)
    {
        self.addToQuestions(newQ)
    }

    func getQs() -> [BankedQuestion]
    {
        
        var quest = self.questions!.array as! [BankedQuestion]


        quest.shuffle()
        

        return quest
    }

    func getQold()
    {

        // get array of all questions and then call extension methods to add to bank
        var quest = [BankedQuestion]()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Question")

        // create context for query
        let context = NSManagedObjectContext()

        do
        {
            quest = try context.fetch(fetchReq) as! [BankedQuestion]
        }
        catch
        {
            print("fetch request failed in method getQs :( error: \(error)")
            return
        }

        // If we don't have questions it doesn't make sense to stay here
        if quest.isEmpty
        {
            return
        }

        // ppreventing index out of bounds
        if quest.count < 25
        {
            print("Less than 25 questions detected, please add more!")
            return
        }

        // picking 25 questions
        for _ in 0..<25
        {
            let indexCap = quest.count

            // random index get
            let indexUse = Int.random(in: 0..<indexCap)

            // Add to the bank
            self.addToQuestions(quest[indexUse])

            // don't want repeats
            quest.remove(at: indexUse)
        }

        try! context.save()
    }
    
    
}
