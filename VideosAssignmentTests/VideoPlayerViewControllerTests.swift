//
//  VideoPlayerViewController.swift
//  VideosAssignmentTests
//
//  Created by Le Tai on 1/17/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import XCTest
@testable import VideosAssignment

class VideoPlayerViewControllerTests: XCTestCase {
    
    let viewController = VideoPlayerViewController.standardVideoPlayerViewController(AppUtils.temporaryVideos())
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testVideoPlayerAnimation() {
        var animation = VideoPlayerAnimation.None
        XCTAssertEqual(animation.duration(), 0)
        
        animation = .SlideToBottom
        XCTAssertEqual(animation.duration(), 0.7)
        
        animation = .SlideToTop
        XCTAssertEqual(animation.duration(), 0.7)
        
        animation = .SlideToRight
        XCTAssertEqual(animation.duration(), 0.5)
        
        animation = .SlideToLeft
        XCTAssertEqual(animation.duration(), 0.5)
        
        animation = .Fade
        XCTAssertEqual(animation.duration(), 0.35)
    }
}
