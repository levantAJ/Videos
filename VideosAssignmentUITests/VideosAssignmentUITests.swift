//
//  VideosAssignmentUITests.swift
//  VideosAssignmentUITests
//
//  Created by Le Tai on 1/17/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import XCTest

class VideosAssignmentUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPlayAllVideos() {
        let app = XCUIApplication()
        let playAllButton = app.buttons["Play all"]
        XCTAssertTrue(playAllButton.exists)
        playAllButton.tap()
        
        let closeButton = app.buttons["Close"]
        XCTAssertTrue(closeButton.exists)
        closeButton.tap()
    }
}
