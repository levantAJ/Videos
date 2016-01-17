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
        wrapperView.addSubview(videoPlayerView)
        selectionStyle = .None
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoPlayerView.frame = CGRect(x: 0, y: 0, width: wrapperView.frame.width, height: wrapperView.frame.height)
    }
    
    func configureWithURL(URL: NSURL) {
        videoPlayerView.player.setURL(URL)
        generateThumbnailFromURL(URL, completion: { (image) -> Void in
            self.thumbnailImageView.image = image
        })
    }
    
    func generateThumbnailFromURL(URL: NSURL, completion: (UIImage) -> Void) {
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
}

//MARK: - Users interactions

extension VideoTableViewCell {
    @IBAction func playButtonTapped(sender: AnyObject) {
        videoPlayerView.player.play()
        playButton.hidden = true
        thumbnailImageView.hidden = true
    }
}

extension Constant {
    struct VideoTableViewCell {
        static let ResueIdentifier = "VideoTableViewCell"
    }
}