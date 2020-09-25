//
//  UIViewExtension.swift
//  RunKeeperProj
//
//  Created by slli on 2020-09-20.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import UIKit

extension UIView {
    public func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
}
