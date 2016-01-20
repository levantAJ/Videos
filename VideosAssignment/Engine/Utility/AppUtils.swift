//
//  AppUtils.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/18/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit
import MediaPlayer

final class AppUtils {
    class func viewController(screenName: String, storyboardName: String, bundle: NSBundle? = nil) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewControllerWithIdentifier(screenName)
    }
    
    class func temporaryVideos() -> [NSURL] {
        return [
            NSURL(string: "http://media.snowballnow.com/video/upload/v1451206914/lcgbutfkqbkhvrfdurrp.mp4")!,
            NSURL(string: "http://media.snowballnow.com/video/upload/v1450752299/deff3bxsmpsrow4i40e0.mp4")!,
            NSURL(string: "http://media.snowballnow.com/video/upload/v1450787135/poareeehaxfqhcyavnnl.mp4")!
        ]
    }
    
    class func isPad() -> Bool {
        return UIDevice.currentDevice().userInterfaceIdiom == .Pad
    }
    
    class func screenSize() -> CGSize {
        return UIScreen.mainScreen().bounds.size
    }
}
