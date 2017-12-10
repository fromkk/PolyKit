//
//  ReusableCell.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import UIKit

protocol RegisterTokenRepresentable {
    init()
}

protocol ReusableCell: class {
    
    associatedtype RegisterToken: RegisterTokenRepresentable
    
}

extension ReusableCell {
    
    static var reuseIdentifier: String { return String(describing: type(of: self)) }
    
}

protocol ReusableTableViewCell: ReusableCell {}

extension ReusableTableViewCell {
    
    static func register(_ tableView: UITableView) -> RegisterToken {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier)
        return RegisterToken.init()
    }
    
    static func reuse(_ tableView: UITableView, indexPath: IndexPath, token: RegisterToken) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Self
    }
    
}

protocol ReusableCollectionViewCell: ReusableCell {}

extension ReusableCollectionViewCell {
    
    static func register(_ tableView: UICollectionView) -> RegisterToken {
        tableView.register(self, forCellWithReuseIdentifier: reuseIdentifier)
        return RegisterToken.init()
    }
    
    static func reuse(_ collectionView: UICollectionView, indexPath: IndexPath, token: RegisterToken) -> Self {
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Self
    }
    
}
