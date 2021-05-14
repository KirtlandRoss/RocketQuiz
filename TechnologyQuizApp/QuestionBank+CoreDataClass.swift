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
    /*
     Jared's to-do list:
     - make method(s) to get questions and store in data structure
        PROGRESS SO FAR
     - randomization
     
     we only want 25 questions in the array per gameplay session. yes there will be more than 25 total in coredata
     
     Kirt said there should be a fetch method in property file extensions (Apres fait: C'est vrai)
     Don't mess w/ property files and settings
     
     Kirt's suggestion: Ditch the fetch request and rework to use self.Questions - return array of Questions
     */
	
	func addQ()
	{

//    let user = User(context: context)
//        for _ in 0...4{
//
//            user.addToResults(Results(context: context))
//            (user.results?.lastObject as! Results).questions = Questions(context: context)
//            (user.results?.lastObject as! Results).catagory = 5
//            (user.results?.lastObject as! Results).completed = false
//
//        }

		// Hard code the questions from the spreadsheet into the bank
		var Qlist = [Question]()
        let context = SceneDelegate().context!
		for _ in 0..<25
		{
            let quest = Question(context: context)
            quest.question = ""
            quest.correctAnswer = ""
            quest.incorrectAnswers = ["","",""]
			Qlist.append(quest)
		}
		
		Qlist[0].question = "What company developed Swift?"
		Qlist[1].question = "What is a protocol?"
		Qlist[2].question = "What language did Swift replace in development for Apple platforms?"
		Qlist[3].question = "Who originally led the development of Swift?"
		Qlist[4].question = "When was Swift first released?"
		
		Qlist[0].correctAnswer = "Apple"
		Qlist[1].correctAnswer = "A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality."
		Qlist[2].correctAnswer = "Objective-C"
		Qlist[3].correctAnswer = "Chris Lattner"
		Qlist[4].correctAnswer = "2014"
		
		Qlist[5].question = "What is Github?"
		Qlist[6].question = "What is open-source software?"
		Qlist[7].question = "What method is used to create a separate copy of a repository?"
		Qlist[8].question = "What non-code file is recommended for every project?"
		Qlist[9].question = "What starts the branch merge process?"
		
		Qlist[5].correctAnswer = "Version/Source control service"
		Qlist[6].correctAnswer = "Software released under a license that permits users to study, change, and redistribute it"
		Qlist[7].correctAnswer = "Fork"
		Qlist[8].correctAnswer = "README"
		Qlist[9].correctAnswer = "Pull request"
		
		Qlist[10].question = "Who invented C++?"
		Qlist[11].question = "What two statements are used in error handling with C++?"
		Qlist[12].question = "What keyword is used to import libraries?"
		Qlist[13].question = "What library is used for basic printing and typing to the console?"
		Qlist[14].question = "What year was C++ first released?"
		
		Qlist[10].correctAnswer = "Bjarne Stroustrup"
		Qlist[11].correctAnswer = "Try and Catch"
		Qlist[12].correctAnswer = "#include"
		Qlist[13].correctAnswer = "iostream"
		Qlist[14].correctAnswer = "1985"
		
		Qlist[15].question = "What paradigm does Java use?"
		Qlist[16].question = "What company owns and develops Java?"
		Qlist[17].question = "What keywords are used for access control?"
		Qlist[18].question = "Who first developed Java?"
		Qlist[19].question = "What mobile platform uses Java?"
		
		Qlist[15].correctAnswer = "Object-Oriented Programming"
		Qlist[16].correctAnswer = "Oracle"
		Qlist[17].correctAnswer = "Private, Public, Protected"
		Qlist[18].correctAnswer = "James Gosling"
		Qlist[19].correctAnswer = "Android"
		
		Qlist[20].question = "What is a GPU?"
		Qlist[21].question = "What part do all others connect to?"
		Qlist[22].question = "What type of cable is used to connect storage devices?"
		Qlist[23].question = "What part handles interpretation and execution of programs?"
		Qlist[24].question = "What is one PC part that isn't required for any build?"
		
		Qlist[20].correctAnswer = "Graphics Processing Unit"
		Qlist[21].correctAnswer = "The motherboard"
		Qlist[22].correctAnswer = "SATA"
		Qlist[23].correctAnswer = "Central Processing Unit"
		Qlist[24].correctAnswer = "Tower case"
		
		for item in Qlist
		{
            item.questionBank = self
            print(item)

			self.addToQuestions(item)
		}
        print(self)
	}
    
    func addQ(newQ : Question)
    {
        self.addToQuestions(newQ)
    }
    
    func getQs() -> [Question]
    {
        let quest = self.questions!.array as! [Question]
        
        let indexCap = quest.count
        
        var questList = [Question]()
        
        //var used = [Int]()
        
        for _ in 0..<25
        {
            
            let indexUse = Int.random(in: 0..<indexCap)
            
            questList.append(quest[indexUse])
            //used.append(indexUse)
        }
        
        return questList
    }
    
    func getQold()
    {
        
        // get array of all questions and then call extension methods to add to bank
        var quest = [Question]()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Question")
        
        // create context for query
        let context = NSManagedObjectContext()
        
        do
        {
            quest = try context.fetch(fetchReq) as! [Question]
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
