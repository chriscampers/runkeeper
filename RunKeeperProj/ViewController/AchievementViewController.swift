//
//  AchievementViewController.swift
//  RunKeeperProj
//
//  Created by Chris Campanelli on 2020-09-20.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import UIKit

let SECTION_HEADER_HEIGHT:CGFloat = 30

class AchievementViewController: BaseViewController, UICollectionViewDelegate {
    
    // UI Element Properties
    var collectionView:UICollectionView?
    
    // Data Properties
    var personalAchievmentsList = [Achievement]()
    var virtualRaceList = [Achievement]()
    
    // Managers
    let achievementManager = AchievementManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Achievments"
        
        // Sort through achievementList to determine each sections data
        sortAchievementList(achievementList: achievementManager.achievementList)

        // Setup UICollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(AchievementCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(AchievementCollectionHeader.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: "headerView")
        self.view.addSubview(collectionView ?? UICollectionView())
        
        // Setup Nav Bar
        let moreBtn = UIBarButtonItem(image: UIImage(named: "MoreButton.png"),
                                      style: .plain,
                                      target: self,
                                      action: nil)
        self.navigationItem.rightBarButtonItem = moreBtn
        self.navigationItem.leftBarButtonItem?.title = ""
    }
    
    func sortAchievementList(achievementList:[Achievement]) {
        for achievement in achievementList {
            if achievement.achievementType == .Personal {
                personalAchievmentsList.append(achievement)
            } else if achievement.achievementType == .VirtualRace {
                virtualRaceList.append(achievement)
            }
        }
    }
    
    func navBarRightButtonPressed() {
        // Do nothing, as it is currently not implemented for this demo
        return
    }
}

extension AchievementViewController: AchievementManagerDelegate {
    func onAchievementsUpdated(achievementList: [Achievement]) {
        // If new achievement data is synced while the user in on
        // the view re-sort the list, and reload the collection
        self.sortAchievementList(achievementList: achievementList)
        collectionView?.reloadData()
    }
}
    
extension AchievementViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return AchievementType.allCases.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let achievementType = AchievementType.init(rawValue: section) ?? AchievementType.UNKNOWN
        // Convert enum to section
        switch achievementType {
        case AchievementType.Personal:
            return personalAchievmentsList.count
        case AchievementType.VirtualRace:
            return virtualRaceList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AchievementCell
        let achievementType = AchievementType.init(rawValue: indexPath.section) ?? AchievementType.UNKNOWN
        let achievement:Achievement?
        
        switch achievementType {
        case AchievementType.Personal:
            achievement = personalAchievmentsList[indexPath.item]
        case AchievementType.VirtualRace:
            achievement = virtualRaceList[indexPath.item]
        default:
            achievement = nil
        }
        if let achievementObj = achievement {
            let boldText = achievementObj.title!
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
            let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

            let normalText = achievementObj.getMetricText() ?? ""
            let normalString = NSMutableAttributedString(string:"\n" + normalText)

            attributedString.append(normalString)
            cell.titleLabel.attributedText = attributedString
            cell.achievementImageView.setImage(achievementObj.url ?? "", placeHolder: nil, completion: nil)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: SECTION_HEADER_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let achievementType = AchievementType.init(rawValue: indexPath.section) ?? AchievementType.UNKNOWN
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath as IndexPath) as! AchievementCollectionHeader

        var titleString:String
        switch achievementType {
        case AchievementType.Personal:
            titleString = "Personal Achievements"
        case AchievementType.VirtualRace:
            titleString = "Virtual Race Achievements"
        default:
            titleString = "null"
        }
        
        headerView.titleLabel.text = titleString

        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // https://stackoverflow.com/questions/55280171/set-width-of-custom-uiview-nib-to-its-parent-collectionviewcell
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 10
        
        let totalSpacing = (2 * 15) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView {
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}
