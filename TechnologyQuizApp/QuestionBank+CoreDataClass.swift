//
//  QuestionBank+CoreDataClass.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/11/21.
//
//

import Foundation
import CoreData


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
    
    func addQ(newQ : Question)
    {
        self.addToQuestions(newQ)
    }
    
    func getQs() -> [Question]
    {
        var quest = self.questions!.array as! [Question]
        
        let indexCap = quest.count
        
//        var questList = [Question]()
        
        //var used = [Int]()
        
        for _ in 0..<25
        {
            
            let indexUse = Int.random(in: 0..<indexCap)
            
            quest.append(quest[indexUse])
            //used.append(indexUse)
        }
        
        return quest
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
