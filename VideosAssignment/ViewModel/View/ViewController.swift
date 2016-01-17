//
//  ViewController.swift
//  VideosAssignment
//
//  Created by Le Tai on 1/17/16.
//  Copyright © 2016 levantAJ. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let videos = [
        NSURL(string: "http://media.snowballnow.com/video/upload/v1451206914/lcgbutfkqbkhvrfdurrp.mp4")!,
        NSURL(string: "http://media.snowballnow.com/video/upload/v1450752299/deff3bxsmpsrow4i40e0.mp4")!,
        NSURL(string: "http://media.snowballnow.com/video/upload/v1450787135/poareeehaxfqhcyavnnl.mp4")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.registerNib(UINib(nibName: Constant.VideoTableViewCell.ResueIdentifier, bundle: nil), forCellReuseIdentifier: Constant.VideoTableViewCell.ResueIdentifier)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

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

