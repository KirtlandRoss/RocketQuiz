//
//  TechnologyQuizAppTests.swift
//  TechnologyQuizAppTests
//
//  Created by Kirtland Ross on 5/8/21.
//

import XCTest
@testable import TechnologyQuizApp

class TechnologyQuizAppTests: XCTestCase {

    func testQuestionOutput(){
        let qb = QuestionBank(context: SceneDelegate().context!)
        qb.addQ()
        print(qb.categoryGroups![3])
    }


}
