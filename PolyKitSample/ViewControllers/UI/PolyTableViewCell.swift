//
//  PolyTableViewCell.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import UIKit

class PolyTableViewCell: UITableViewCell, ReusableTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private var isSetup: Bool = false
    private func setup() {
        guard !isSetup else { return }
        defer { isSetup = true }
        
        contentView.addSubview(thumbnailImageView, layouts: [
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 120.0),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 120.0),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            ])
        
        contentView.addSubview(titleLabel, layouts: [
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 4.0).priority(.defaultHigh),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).priority(.defaultHigh),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
    }
    
    struct PolyTableViewCellRegisterToken: RegisterTokenRepresentable {}
    
    typealias RegisterToken = PolyTableViewCellRegisterToken
    
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()
    
    
}
