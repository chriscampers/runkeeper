//
//  AchievementCell.swift
//  RunKeeperProj
//
//  Created by Chris Campanelli on 2020-09-22.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import UIKit

class AchievementCell: UICollectionViewCell {
    
    // StackView to cover view
    var stackView:UIStackView = UIStackView()
    
    let achievementImageView: AsyncImageView = {
        let imageView = AsyncImageView();
            return imageView
        }()


    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tokyo Virtual Race Half Marathon"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()

    override init(frame: CGRect) {
           super.init(frame: frame)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(stackView)
    
        achievementImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        achievementImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // Setup main stackview
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.pinEdges(to: contentView)
        
        self.backgroundColor = UIColor.white
   
        stackView.addArrangedSubview(achievementImageView)
        stackView.addArrangedSubview(titleLabel)
    }
}
