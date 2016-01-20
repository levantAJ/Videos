//
//  ViewController.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/17/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit

final class VideoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playAllButtonBottomConstraint: NSLayoutConstraint!
    lazy var videos = AppUtils.temporaryVideos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.registerNib(UINib(nibName: Constant.VideoTableViewCell.ResueIdentifier, bundle: nil), forCellReuseIdentifier: Constant.VideoTableViewCell.ResueIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 146
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
    }
}

//MARK: -Users interactions

extension VideoViewController {
    @IBAction func playAllButtonTapped(sender: AnyObject) {
        let videoPlayerViewController = VideoPlayerViewController.standardVideoPlayerViewController(videos, videoPlayerAnimation: .Fade)
        videoPlayerViewController.playVideos()
        presentViewController(videoPlayerViewController, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource

extension VideoViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constant.VideoTableViewCell.ResueIdentifier, forIndexPath: indexPath) as! VideoTableViewCell
        cell.configureWithURL(videos[indexPath.row])
        return cell
    }
}

extension VideoViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? VideoTableViewCell where tableView.indexPathsForVisibleRows?.indexOf(indexPath) == nil else { return }
        cell.pause()
    }
}



