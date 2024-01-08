//
//  SceneDelegate.swift
//  RandomCat
//
//  Created by 이찬호 on 2024/01/08.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        let mainVC = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = mainVC
        self.window = window
        window.makeKeyAndVisible()
    }

}

