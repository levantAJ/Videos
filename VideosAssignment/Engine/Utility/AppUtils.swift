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
}
