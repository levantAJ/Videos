//
//  VideoWithCollectionViewController.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/20/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit

final class VideoWithCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    lazy var videos = AppUtils.temporaryVideos()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.registerNib(UINib(nibName: Constant.VideoCollectionViewCell.ResueIdentifier, bundle: nil), forCellWithReuseIdentifier: Constant.VideoCollectionViewCell.ResueIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        if !AppUtils.isPad() {
            collectionViewFlowLayout.scrollDirection = .Vertical
        }
    }

}

//MARK: -Users interactions

extension VideoWithCollectionViewController {
    @IBAction func playAllButtonTapped(sender: AnyObject) {
        let videoPlayerViewController = VideoPlayerViewController.standardVideoPlayerViewController(videos, videoPlayerAnimation: .Fade)
        videoPlayerViewController.playVideos()
        presentViewController(videoPlayerViewController, animated: true, completion: nil)
    }
}

extension VideoWithCollectionViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constant.VideoCollectionViewCell.ResueIdentifier, forIndexPath: indexPath) as! VideoCollectionViewCell
        cell.configureWithURL(videos[indexPath.item])
        return cell
    }
}

extension VideoWithCollectionViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //TODO: We need concern when implement on iPad as well
        return CGSize(width: VideoCollectionViewCell.width(), height: Constant.VideoCollectionViewCell.DefaultHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let padding = AppUtils.isPad() ? CGFloat(16) : CGFloat(0) //TODO: Depend on kind of device iPhone, iPad we will have difference padding
        return UIEdgeInsets(top: 0, left: padding, bottom: 8, right: padding)
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? VideoCollectionViewCell where collectionView.indexPathsForVisibleItems().indexOf(indexPath) == nil else { return }
        cell.pause()
    }
}
