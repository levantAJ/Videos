//
//  VideoTableViewCell.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/17/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit
import MediaPlayer

final class VideoTableViewCell: UITableViewCell {
    
    var video: MPMoviePlayerController!

    override func awakeFromNib() {
        super.awakeFromNib()
        video = MPMoviePlayerController()
        video.controlStyle = .None
        video.scalingMode = .AspectFit
        contentView.addSubview(video.view)
    }
    
    func configureWithURL(URL: NSURL) {
        video.contentURL = URL
        video.prepareToPlay()
    }
}

extension Constant {
    struct VideoTableViewCell {
        static let ResueIdentifier = "VideoTableViewCell"
    }
}