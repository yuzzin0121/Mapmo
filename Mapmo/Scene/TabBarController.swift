//
//  TabBarController.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        addViewControllers()
    }
    
    private func configureView() {
        tabBar.backgroundColor = ColorStyle.customWhite
        tabBar.tintColor = ColorStyle.customBlack
        tabBar.unselectedItemTintColor = ColorStyle.customGray
    }

    private func addViewControllers() {
        let mapVC = MapViewController()
        let mapNav = UINavigationController(rootViewController: mapVC)
        mapNav.tabBarItem = UITabBarItem(title: nil, image: TabItem.map.image, selectedImage: TabItem.map.selectedImage)
  
        let recordListVC = RecordListViewController()
        let recordListNav = UINavigationController(rootViewController: recordListVC)
        recordListNav.tabBarItem = UITabBarItem(title: nil, image: TabItem.list.image, selectedImage: TabItem.list.image)
        
        let historyVC = HistoryViewController()
        let historyNav = UINavigationController(rootViewController: historyVC)
        historyNav.tabBarItem = UITabBarItem(title: nil, image: TabItem.history.image, selectedImage: TabItem.history.selectedImage)
        
//        [mapNav, recordListNav, historyNav].forEach {
//            $0.setupBarAppearance()
//        }
        
        self.viewControllers = [mapNav, recordListNav, historyNav]
    }
}
