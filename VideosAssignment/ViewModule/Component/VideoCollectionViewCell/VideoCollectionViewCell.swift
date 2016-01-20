//
//  VideoCollectionViewCell.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/20/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit
import VIMVideoPlayer

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var videoPlayerView: VIMVideoPlayerView!
    var videoReadyToPlay = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoPlayerView = VIMVideoPlayerView()
        videoPlayerView.setVideoFillMode(AVLayerVideoGravityResizeAspectFill)
        videoPlayerView.player.looping = false
        videoPlayerView.delegate = self
        wrapperView.addSubview(videoPlayerView)
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
    
    class func width() -> CGFloat {
        return AppUtils.isPad() ? 50 : AppUtils.screenSize().width
    }
}

//MARK: - Users interactions

extension VideoCollectionViewCell {
    @IBAction func playButtonTapped(sender: AnyObject) {
        videoPlayerView.player.play()
        playButton.hidden = true
        if !videoReadyToPlay {
            loadingView.startAnimating()
        }
    }
}

//MARK: - VIMVideoPlayerViewDelegate

extension VideoCollectionViewCell: VIMVideoPlayerViewDelegate {
    func videoPlayerViewDidReachEnd(videoPlayerView: VIMVideoPlayerView!) {
        playButton.hidden = false
        loadingView.stopAnimating()
    }
    
    func videoPlayerViewIsReadyToPlayVideo(videoPlayerView: VIMVideoPlayerView!) {
        videoReadyToPlay = true
        loadingView.stopAnimating()
        thumbnailImageView.hidden = true
    }
}

extension Constant {
    struct VideoCollectionViewCell {
        static let ResueIdentifier = "VideoCollectionViewCell"
        static let DefaultHeight = CGFloat(170)
    }
}
