//
//  LoginCoordinator.swift
//
//
//  Created by Ekko on 6/3/24.
//

import UIKit

import CoreKit
import HomeScene

public final class LoginCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    weak public var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    private let window: UIWindow
    
    public init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    public func start() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController?.setViewControllers([loginViewController], animated: false)
    }
    
    public func moveToHomeScene() {
        let homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator
            .parentCoordinator = self.parentCoordinator
        parentCoordinator?.addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
        window.rootViewController = homeCoordinator.navigationController
        
        if let parentCoordinator = parentCoordinator {
            parentCoordinator.removeChildCoordinator(self)
        }
    }
}
