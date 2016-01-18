//
//  VideoPlayerViewController.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/18/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit
import VIMVideoPlayer

final class VideoPlayerViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var videos = [NSURL]()
    var videoPlayerAnimation = VideoPlayerAnimation.None
    var currentVideoIndex = 0
    var firstVideoPlayerView: VIMVideoPlayerView! //TODO: We will subclassing this view to support thumbnail image
    var secondVideoPlayerView: VIMVideoPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupVideoPlayers()
        closeButton.addBorder()
        closeButton.clipsToBounds = true
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func playVideos(videos: [NSURL], videoPlayerAnimation: VideoPlayerAnimation = .None) {
        self.videos = videos
        self.videoPlayerAnimation = videoPlayerAnimation
        resetPlaying()
        playVideoPlayerView(firstVideoPlayerView)
    }
    
    private func setupVideoPlayers() {
        firstVideoPlayerView = VIMVideoPlayerView()
        setupVideoPlayerView(firstVideoPlayerView)
        secondVideoPlayerView = VIMVideoPlayerView()
        setupVideoPlayerView(secondVideoPlayerView)
    }
    
    private func setupVideoPlayerView(videoPlayerView: VIMVideoPlayerView) {
        videoPlayerView.setVideoFillMode(AVLayerVideoGravityResizeAspectFill)
        videoPlayerView.player.looping = false
        videoPlayerView.delegate = self
        videoPlayerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "triggerControl"))
        videoPlayerView.userInteractionEnabled = true
        videoPlayerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        videoPlayerView.hidden = true
        view.addSubview(videoPlayerView)
        guard currentVideoIndex < videos.count else { return }
        videoPlayerView.player.setURL(videos[currentVideoIndex]) // Load video before play
    }
    
    private func playVideoPlayerView(videoPlayerView: VIMVideoPlayerView) {
        animationVidePlayerView(videoPlayerView)
        videoPlayerView.player.play()
        view.bringSubviewToFront(videoPlayerView)
        view.bringSubviewToFront(closeButton)
        currentVideoIndex++
        
        // Load another video to realy play
        guard currentVideoIndex < videos.count else { return }
        if videoPlayerView == firstVideoPlayerView {
            secondVideoPlayerView.player.setURL(videos[currentVideoIndex])
        } else {
            firstVideoPlayerView.player.setURL(videos[currentVideoIndex])
        }
    }
    
    private func resetPlaying() {
        currentVideoIndex = 0
        guard currentVideoIndex < videos.count else { return }
        firstVideoPlayerView.player.setURL(videos[currentVideoIndex])
    }
    
    private func animationVidePlayerView(videoPlayerView: VIMVideoPlayerView) {
        if currentVideoIndex != 0 {
            var shouldAnimated = false
            switch videoPlayerAnimation {
            case .None:
                videoPlayerView.frame = CGRect(origin: CGPoint.zero, size: videoPlayerView.frame.size)
                videoPlayerView.hidden = false
            case .Fade:
                videoPlayerView.frame = CGRect(origin: CGPoint.zero, size: videoPlayerView.frame.size)
                videoPlayerView.alpha = 0
                UIView.animateWithDuration(0.25, animations: {
                    videoPlayerView.alpha = 1
                    }, completion: { _ in
                        videoPlayerView.hidden = false
                    })
            case .SlideToLeft:
                videoPlayerView.frame = CGRect(origin: CGPoint(x: videoPlayerView.frame.width, y: videoPlayerView.frame.minY), size: videoPlayerView.frame.size)
                shouldAnimated = true
            case .SlideToRight:
                videoPlayerView.frame = CGRect(origin: CGPoint(x: -videoPlayerView.frame.width, y: videoPlayerView.frame.minY), size: videoPlayerView.frame.size)
                shouldAnimated = true
            case .SlideToTop:
                videoPlayerView.frame = CGRect(origin: CGPoint(x: 0, y: videoPlayerView.frame.maxX), size: videoPlayerView.frame.size)
                shouldAnimated = true
            case .SlideToBottom:
                videoPlayerView.frame = CGRect(origin: CGPoint(x: 0, y: -videoPlayerView.frame.height), size: videoPlayerView.frame.size)
                shouldAnimated = true
            }
            if shouldAnimated {
                videoPlayerView.hidden = false
                UIView.animateWithDuration(0.5, animations: {
                    videoPlayerView.frame = CGRect(origin: CGPoint.zero, size: videoPlayerView.frame.size)
                })
            }
        } else {
            videoPlayerView.hidden = false
        }
    }
}

//MARK: -Users Interactions

extension VideoPlayerViewController {
    @IBAction func closeButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {
            self.resetPlaying()
            self.firstVideoPlayerView.player.reset()
            self.secondVideoPlayerView.player.reset()
        })
    }
    
    @IBAction func playButtonTapped(sender: AnyObject) {
        resetPlaying()
        playVideoPlayerView(firstVideoPlayerView)
    }
    
    func hideCloseButton() {
        closeButton.hiddenWithAnimation(hidden: true)
    }
    
    func triggerControl() {
        if closeButton.alpha == 0 {
            closeButton.hiddenWithAnimation(hidden: false)
            NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "hideCloseButton", userInfo: nil, repeats: false)
        } else {
            closeButton.hiddenWithAnimation(hidden: true)
        }
    }
}

//MARK: -VIMVideoPlayerViewDelegate

extension VideoPlayerViewController: VIMVideoPlayerViewDelegate {
    func videoPlayerViewDidReachEnd(videoPlayerView: VIMVideoPlayerView!) {
        if currentVideoIndex < videos.count {
            if videoPlayerView == firstVideoPlayerView {
                playVideoPlayerView(secondVideoPlayerView)
            } else {
                playVideoPlayerView(firstVideoPlayerView)
            }
        } else {
            view.bringSubviewToFront(closeButton)
            view.bringSubviewToFront(playButton)
            closeButton.hiddenWithAnimation(hidden: false)
            playButton.hiddenWithAnimation(hidden: false)
        }
    }
}
