//
//  UIViewController.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/19/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithTitle(title: String, message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Cancel, handler: nil))
        presentViewController(alertVC, animated: true, completion: nil)
    }

}
