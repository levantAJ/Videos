//
//  UIView.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/18/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit

extension UIView {
    
    func hiddenWithAnimation(animated: Bool = true, hidden: Bool) {
        if animated {
            alpha = hidden ? 0 : 1
        } else {
            UIView.animateWithDuration(0.5, animations: {
                self.alpha = hidden ? 0 : 1
            })
        }
    }

}
