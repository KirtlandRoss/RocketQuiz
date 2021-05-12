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
     - randomization
     
     we only want 25 questions in the array per gameplay session. yes there will be more than 25 total in coredata
     
     Kirt said there should be a fetch method in some extension
     */
    
    // Store question objects here
    static var questions = [Question]()
    
    /*func getQs()
    {
        var tempQ = [Question]()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Question")
        
        do
        {
            tempQ = try DBHelper.inst.context
        }
        catch
        {
            
        }
    }*/
    
    
}
