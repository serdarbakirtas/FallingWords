//
//  AppDelegate.swift
//  FallinWords
//
//  Created by Hasan on 22.11.20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let gameVC = GameViewController()
        let navigationController = UINavigationController()
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: ColorPallet.ON_ACCENT!,
                                                                  .font : UIFont.systemFont(ofSize: 14)]
        navigationController.navigationBar.barTintColor = ColorPallet.ACCENT
        navigationController.navigationBar.tintColor = ColorPallet.ON_TILE_ELEMENT
        navigationController.navigationBar.isTranslucent = false
        navigationController.viewControllers.append(gameVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
