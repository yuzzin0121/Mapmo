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
    
    func showAlert(title: String, message: String, actionTitle: String, completionHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: actionTitle, style: .destructive, handler: completionHandler)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true)
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
