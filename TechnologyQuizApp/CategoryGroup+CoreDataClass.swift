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

}

enum category : Int64{
    case swift = 1
    case xcode = 2
    case coredata = 3
    case java = 4
    case c = 5
}
