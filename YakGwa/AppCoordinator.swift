//
//  AppCoordinator.swift
//  YakGwa
//
//  Created by Ekko on 6/2/24.
//

import UIKit

import Common
import SceneKit
import SplashScene
import LoginScene

class AppCoordinator: Coordinator {
    var window: UIWindow
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        showSplash()
    }

    private func showSplash() {
        let splashCoordinator = SplashCoordinator(window: window)
        splashCoordinator.parentCoordinator = self
        addChildCoordinator(splashCoordinator)
        splashCoordinator.start()
    }
}

