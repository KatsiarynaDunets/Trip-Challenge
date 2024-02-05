//
//  AppDelegate.swift
//  Trip Challenge
//
//  Created by Kate on 13/11/2023.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureRealm()
        return true
    }

    private func configureRealm() {
        // Настройка конфигурации Realm
        let config = Realm.Configuration(
            // Изменить номер версии схемы при каждом изменении формата данных
            schemaVersion: 1,

            // Блок миграции для обновления данных с учетом изменений схемы
            migrationBlock: { migration, oldSchemaVersion in
                // код миграции, если необходимо обработать изменения
                // Например, при добавлении новых полей или изменении существующих
                if oldSchemaVersion < 1 {
                    // Realm автоматически обрабатывает добавление новых полей
                }
                // Для последующих версий добавитьь дополнительные условия
            })

        // Применение настройки конфигурации по умолчанию
        Realm.Configuration.defaultConfiguration = config
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
    }
}
