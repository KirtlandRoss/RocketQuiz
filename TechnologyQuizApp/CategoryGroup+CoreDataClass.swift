//
//  CategoryGroup+CoreDataClass.swift
//  TechnologyQuizApp
//
//  Created by Kirtland Ross on 5/13/21.
//
//

import Foundation
import CoreData

@objc(CategoryGroup)
public class CategoryGroup: NSManagedObject {

    func randomize(){
        var quest  = self.questions?.allObjects as! [BankedQuestion]
        let indexCap = quest.count

        // random index get
        let indexUse = Int.random(in: 0..<indexCap)

        // Add to the bank
        self.addToQuestions(quest[indexUse])

        // don't want repeats
        quest.remove(at: indexUse)
    }

}

enum category : Int64{
    case swift = 1
    case github = 2
    case c = 3
    case java = 4
    case hardware = 5
}
