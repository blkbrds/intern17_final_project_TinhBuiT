//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit
import SVProgressHUD
import RealmSwift

typealias HUD = SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configRealm()
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController()
        let navi = UINavigationController(rootViewController: vc)

        window?.rootViewController = navi
        window?.makeKeyAndVisible()

        return true
    }

    func configRealm() {
            let fileManager = FileManager.default
                var config = Realm.Configuration()
                let urls = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)
                if let applicationSupportURL = urls.last {
                    do {
                        try fileManager.createDirectory(at: applicationSupportURL, withIntermediateDirectories: true, attributes: nil)
                        config.fileURL = applicationSupportURL.appendingPathComponent("demo.realm")
                    } catch let err {
                        print(err)
                    }
                }
            config.deleteRealmIfMigrationNeeded = true
                Realm.Configuration.defaultConfiguration = config
        }
}
