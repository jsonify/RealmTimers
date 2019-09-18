//
//  MathPreFireViewControllerTests.swift
//  RealmTimersTests
//
//  Created by Jason Rueckert on 9/17/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import XCTest
@testable import RealmTimers

class MathPreFireViewControllerTests: XCTestCase {

    var mathVC: MathPreFireViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumbersSumCorrectly() {
        mathVC = MathPreFireViewController()
        let num1 = 2
        let num2 = 3
        let answer = 5
        let mathCheck = mathVC.checkAnswer(num1, num2, answer)
        XCTAssertTrue(mathCheck)
    }
    
    func testNumberDoNotSum() {
        mathVC = MathPreFireViewController()
        let num1 = 2
        let num2 = 3
        let answer = 6
        let mathCheck = mathVC.checkAnswer(num1, num2, answer)
        XCTAssertFalse(mathCheck)
    }

}
