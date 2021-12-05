//
//  AppDelegate.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 30/11/2021.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var container : Swinject.Container!
    var becomeActiveDidCalled = false

    static var app : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
     }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        RealmUtility.migrate()
        setupDependencies()
        AppDelegateUtils.routeToHomePage()
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


fileprivate extension AppDelegate {
    func setupDependencies() {
        container = Container()
        ListStockPricePage.register(using: container)
        DetailStockPricePage.register(using: container)
    }
}

