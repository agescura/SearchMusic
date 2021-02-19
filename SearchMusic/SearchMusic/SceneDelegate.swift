//
//  SceneDelegate.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 19/2/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        window?.rootViewController = ListViewController()
    }
}

