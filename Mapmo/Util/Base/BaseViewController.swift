//
//  BaseViewController.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
    }
    
    func configureNavigationItem() {
        
    }
    
    // 메인 탭바로 화면 전환
    func showMainTabBar() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let tabBarController = TabBarController()
        sceneDelegate?.window?.rootViewController = tabBarController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
