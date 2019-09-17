//
//  MainViewControllerTests.swift
//  MainViewControllerTests
//
//  Created by Jason Rueckert on 9/4/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import XCTest
@testable import RealmTimers

class MainViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTitleIsWaker() {
        let storyboard = UIStoryboard(name: "MainViewController", bundle: nil)
        let launch = storyboard.instantiateInitialViewController() as! MainViewController
        let _ = launch.view
        XCTAssertEqual("Waker", launch.title)
    }

}
