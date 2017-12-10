//
//  ViewController.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import UIKit
import PolyKit

class ViewController: UIViewController {
    
    let dataSource = PolyDataSource()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 136.0
        dataSource.register(tableView: tableView)
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView, layouts: [
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        let query = PolyAssetsQuery(keywords: "Cat", format: Poly3DFormat.obj)
        let polyApi = PolyAPI(apiKey: /* Poly API Key is HERE!!! */)
        polyApi.assets(with: query) { (result) in
            switch result {
            case .success(let assets):
                self.dataSource.assets = assets.assets ?? []
            case .failure(_):
                self.showFetchFailedAlert()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func showFetchFailedAlert() {
        let alertController = UIAlertController(title: "Failed fetch from Poly API.", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let asset = dataSource.assets[indexPath.row]
        
        let cameraViewController = CameraViewController.make(with: asset)
        navigationController?.pushViewController(cameraViewController, animated: true)
    }
    
}
