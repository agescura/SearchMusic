//
//  SceneDelegate.swift
//  SearchMusic
//
//  Created by Albert Gil Escura on 19/2/21.
//

import UIKit
import DomainLayer

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let repository = DiscogsRepository()
        let useCase = SearchUseCase(with: repository)
        let listViewModel = ListViewModel(with: useCase)
        let listViewController = ListViewController()
        listViewController.viewModel = listViewModel
        let mainNavigationController = MainNavigationController(rootViewController: listViewController)
        
        
        window?.rootViewController = mainNavigationController
    }
}

