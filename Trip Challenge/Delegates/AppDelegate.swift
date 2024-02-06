//
//  AppDelegate.swift
//  Trip Challenge
//
//  Created by Kate on 13/11/2023.
//

import RealmSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureRealm() // Configure Realm database
        return true
    }

    private func configureRealm() {
        // Configure Realm database with schema version and migration block
        let config = Realm.Configuration(
            // Update schema version with every change in data format
            schemaVersion: 1,

            // Migration block to handle changes in schema
            migrationBlock: { _, oldSchemaVersion in
                // Migration code, if necessary, to handle changes
                // For example, when adding new fields or modifying existing ones
                if oldSchemaVersion < 1 {
                    // Realm automatically handles adding new fields
                }
                // Add additional conditions for subsequent versions
            })

        // Apply the default configuration setting
        Realm.Configuration.defaultConfiguration = config
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Return a scene configuration to use when creating a new scene session
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
