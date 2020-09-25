//
//  AchievementCellHeader.swift
//  RunKeeperProj
//
//  Created by Christopher Campanelli on 2020-09-24.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import Foundation
import UIKit

class AchievementCollectionHeader: UICollectionReusableView {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.customLabel(title: "Title",
                          font: .systemFont(ofSize: 20),
                          titleColor: .black,
                          textAlignment: .left,
                          numberOfLines: 1)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .systemGray6
        addSubview(titleLabel)
    }

    func setupConstraints() {
        // Title label constraints.
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension UILabel {

    func customLabel(title: String,
                     font: UIFont,
                     titleColor: UIColor,
                     textAlignment: NSTextAlignment,
                     numberOfLines: Int)
    {
        self.text = title
        self.textAlignment = textAlignment
        self.font = font
        self.textColor = titleColor
        self.numberOfLines = numberOfLines
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

