//
//  HomeViewController.swift
//  RunKeeperProj
//
//  Created by Chris Campanelli on 2020-09-20.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var stackView:UIStackView = UIStackView()
    let achievementsPageButton:UIButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RunKeeper"
        
        // Setup StackView
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.pinEdges(to: view)
    
        // Setup Button
        setupAchievementButton()
        stackView.addArrangedSubview(achievementsPageButton)
    }
    
    func setupAchievementButton() {
        achievementsPageButton.setTitle("View Achievements", for: .init())
        achievementsPageButton.setTitleColor(UIColor.blue, for: .init())
        achievementsPageButton.backgroundColor = UIColor.white
        achievementsPageButton.titleLabel?.adjustsFontSizeToFitWidth = true;
        achievementsPageButton.addTarget(self, action: #selector(self.achievementsPageButton(_:)), for: .touchUpInside)
    }

    @objc private func achievementsPageButton(_ sender: UIButton?) {
        let vc = AchievementViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
