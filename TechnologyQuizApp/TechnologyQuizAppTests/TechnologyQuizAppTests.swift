//
//  TechnologyQuizAppTests.swift
//  TechnologyQuizAppTests
//
//  Created by Kirtland Ross on 5/8/21.
//

import XCTest
@testable import TechnologyQuizApp

class TechnologyQuizAppTests: XCTestCase {


    func testFetchScore(){
        var dbhelp = DBHelper()
        dbhelp.avrgScore()

    }

}
