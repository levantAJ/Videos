//
//  AppConstant.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/17/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit

struct Constant {
    struct Image {
        static let Thumbnail = UIImage(named: "ic_place_loading")!
        static let Play = UIImage(named: "play")!
    }
}

enum VideoPlayerAnimation {
    case None
    case Fade
    case SlideToLeft
    case SlideToRight
    case SlideToTop
    case SlideToBottom
}