//
//  ViewController.swift
//  RunKeeperProj
//
//  Created by Chris Campanelli on 2020-09-20.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Nav Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.CustomColors.BlueRunkeeper
    }
}

