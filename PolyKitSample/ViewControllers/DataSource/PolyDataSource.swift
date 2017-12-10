//
//  PolyDataSource.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import UIKit
import PolyKit

class PolyDataSource: NSObject, UITableViewDataSource {
    
    weak var tableView: UITableView?
    
    var assets: [PolyAsset] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var registerToken: PolyTableViewCell.RegisterToken!
    
    func register(tableView: UITableView) {
        registerToken = PolyTableViewCell.register(tableView)
        tableView.dataSource = self
        self.tableView = tableView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PolyTableViewCell.reuse(tableView, indexPath: indexPath, token: registerToken)
        configure(cell: cell, asset: assets[indexPath.row])
        return cell
    }
    
    private func configure(cell: PolyTableViewCell, asset: PolyAsset) {
        cell.titleLabel.text = asset.displayName
        
        guard let urlString = asset.thumbnail?.url, let url = URL(string: urlString) else { return }
        
        let downloader = ImageDownloader()
        downloader.download(with: url, success: { (image) in
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = image
            }
        }) { (error) in
            debugPrint(#function, "error", error)
        }
    }
    
}
