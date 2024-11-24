//
//  SceneDelegate.swift
//  BrainBitDemo
//
//  Created by Aseatari on 17.02.2023.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
//        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//        window?.windowScene = windowScene
//        window?.rootViewController = createTabBar()
//        window?.makeKeyAndVisible()
    }
    
    func createLiveECGNavigationController() -> UINavigationController {
        let liveECGViewController = LiveECGViewController()
        liveECGViewController.title = "Live ECG"
        liveECGViewController.tabBarItem.image = UIImage(systemName: "heart")
        
        return UINavigationController(rootViewController: liveECGViewController)
    }
    
    func createProfileNavigationController() -> UINavigationController {
        let profileViewController = ProfileViewController()
        profileViewController.title = "Profile"
        profileViewController.tabBarItem.image = UIImage(systemName: "person")
        
        return UINavigationController(rootViewController: profileViewController)
    }

    func createTabBar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabbar.viewControllers = [createLiveECGNavigationController(), createProfileNavigationController()]
        
        return tabbar
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

