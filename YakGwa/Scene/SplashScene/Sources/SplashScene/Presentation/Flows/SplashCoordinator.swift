//
//  SplashCoordinator.swift
//
//
//  Created by Kim Dongjoo on 6/3/24.
//

import UIKit
import Common
import LoginScene

final public class SplashCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    public weak var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    private let window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        let splashViewController = SplashViewController()
        splashViewController.coordinator = self
        
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showLogin()
        }
    }
    
    private func showLogin() {
        let loginCoordinator = LoginCoordinator()
        loginCoordinator.parentCoordinator = self.parentCoordinator
        parentCoordinator?.addChildCoordinator(loginCoordinator)
        loginCoordinator.start()
        window.rootViewController = loginCoordinator.navigationController
        
        if let parentCoordinator = parentCoordinator {
            parentCoordinator.removeChildCoordinator(self)
        }
    }
}
