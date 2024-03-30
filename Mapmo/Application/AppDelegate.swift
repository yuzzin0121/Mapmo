//
//  AppDelegate.swift
//  Mapmo
//
//  Created by 조유진 on 3/7/24.
//

import UIKit
import NMapsMap
import IQKeyboardManagerSwift
import FirebaseCore
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        NMFAuthManager.shared().clientId = APIKey.NMFClientId
        IQKeyboardManager.shared.enable = true
        
        let configuration = Realm.Configuration(schemaVersion: 1) {
            migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                print("Schema: 0 -> 1")
                migration.renameProperty(onType: Place.className(), from: "roadAddress", to: "address")
            }
        }
        
        Realm.Configuration.defaultConfiguration = configuration
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

