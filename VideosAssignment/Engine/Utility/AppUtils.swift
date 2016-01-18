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
    class func generateThumbnailFromURL(URL: NSURL, completion: (UIImage) -> Void) {
        let asset = AVURLAsset(URL: URL)
        let image = AVAssetImageGenerator(asset: asset)
        let time = CMTime(value: 1, timescale: 1)
        image.generateCGImagesAsynchronouslyForTimes([NSValue(CMTime: time)], completionHandler: { (requestedTime, cgImage, actualTime, result, error) -> Void in
            guard let cgImage = cgImage else { return }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(UIImage(CGImage: cgImage))
            })
        })
    }
    
    class func viewController(screenName: String, storyboardName: String, bundle: NSBundle? = nil) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewControllerWithIdentifier(screenName)
    }
}
