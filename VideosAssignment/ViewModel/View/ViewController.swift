//
//  ViewController.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/17/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit
import VIMVideoPlayer

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let videos = [
        NSURL(string: "http://media.snowballnow.com/video/upload/v1451206914/lcgbutfkqbkhvrfdurrp.mp4")!,
        NSURL(string: "http://media.snowballnow.com/video/upload/v1450752299/deff3bxsmpsrow4i40e0.mp4")!,
        NSURL(string: "http://media.snowballnow.com/video/upload/v1450787135/poareeehaxfqhcyavnnl.mp4")!
    ]
    var currentVideoIndex = 0
    var firstVideoPlayerView: VIMVideoPlayerView! //TODO: We will subclassing this view to support thumbnail image
    var secondVideoPlayerView: VIMVideoPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupVideoPlayers()
    }
    
    private func setupTableView() {
        tableView.registerNib(UINib(nibName: Constant.VideoTableViewCell.ResueIdentifier, bundle: nil), forCellReuseIdentifier: Constant.VideoTableViewCell.ResueIdentifier)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 146
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
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
        videoPlayerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        videoPlayerView.hidden = true
        view.addSubview(videoPlayerView)
    }
    
    private func playVideoPlayerView(videoPlayerView: VIMVideoPlayerView) {
        guard currentVideoIndex < videos.count else { return }
        videoPlayerView.player.setURL(videos[currentVideoIndex])
        videoPlayerView.hidden = false
        videoPlayerView.player.play()
        view.bringSubviewToFront(videoPlayerView)
        currentVideoIndex++
    }
}

//MARK: -Users interactions

extension ViewController {
    @IBAction func playAllButtonTapped(sender: AnyObject) {
        playVideoPlayerView(firstVideoPlayerView)
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constant.VideoTableViewCell.ResueIdentifier, forIndexPath: indexPath) as! VideoTableViewCell
        cell.configureWithURL(videos[indexPath.row])
        return cell
    }
}

//MARK: -VIMVideoPlayerViewDelegate

extension ViewController: VIMVideoPlayerViewDelegate {
    func videoPlayerViewDidReachEnd(videoPlayerView: VIMVideoPlayerView!) {
        if videoPlayerView == firstVideoPlayerView {
            playVideoPlayerView(secondVideoPlayerView)
        } else {
            playVideoPlayerView(firstVideoPlayerView)
        }
    }
}



