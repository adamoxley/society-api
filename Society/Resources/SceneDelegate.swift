//
//  SceneDelegate.swift
//  Society
//
//  Created by Adam Oxley on 13/07/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { fatalError() }

        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarViewController = UITabBarController()

        let service = InterestNetwork()
        let viewModel = InterestListViewModel(with: service)
        let dashboardViewController = InterestListViewController(viewModel: viewModel)
        
        let dashboardTabItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 0)
        dashboardViewController.tabBarItem = dashboardTabItem

        let viewControllerList = [dashboardViewController].map {
            UINavigationController(rootViewController: $0)
        }

        tabBarViewController.viewControllers = viewControllerList
        tabBarViewController.tabBar.barTintColor = UIColor.asset(.tiercharyGrey)
        tabBarViewController.tabBar.tintColor = UIColor.asset(.action)
        tabBarViewController.tabBar.isTranslucent = false

        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

