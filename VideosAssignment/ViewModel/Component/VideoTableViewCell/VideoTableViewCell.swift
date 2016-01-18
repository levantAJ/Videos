//
//  VideoTableViewCell.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/17/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit
import MediaPlayer
import VIMVideoPlayer

final class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    var videoPlayerView: VIMVideoPlayerView!

    override func awakeFromNib() {
        super.awakeFromNib()
        videoPlayerView = VIMVideoPlayerView()
        videoPlayerView.setVideoFillMode(AVLayerVideoGravityResizeAspectFill)
        videoPlayerView.player.looping = false
        videoPlayerView.delegate = self
        wrapperView.addSubview(videoPlayerView)
        selectionStyle = .None
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoPlayerView.frame = CGRect(x: 0, y: 0, width: wrapperView.frame.width, height: wrapperView.frame.height)
    }
    
    func configureWithURL(URL: NSURL) {
        videoPlayerView.player.setURL(URL)
    }
    
    func pause() {
        videoPlayerView.player.pause()
        playButton.hidden = false
    }
}

//MARK: - Users interactions

extension VideoTableViewCell {
    @IBAction func playButtonTapped(sender: AnyObject) {
        videoPlayerView.player.play()
        playButton.hidden = true
        thumbnailImageView.hidden = true
    }
}

//MARK: -

extension VideoTableViewCell: VIMVideoPlayerViewDelegate {
    func videoPlayerViewDidReachEnd(videoPlayerView: VIMVideoPlayerView!) {
        playButton.hidden = false
    }
}

extension Constant {
    struct VideoTableViewCell {
        static let ResueIdentifier = "VideoTableViewCell"
    }
}