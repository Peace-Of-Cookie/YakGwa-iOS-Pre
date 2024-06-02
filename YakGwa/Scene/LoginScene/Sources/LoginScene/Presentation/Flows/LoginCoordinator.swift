//
//  LoginCoordinator.swift
//
//
//  Created by Ekko on 6/3/24.
//

import UIKit

import Common

public final class LoginCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    weak public var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    
    public init() {
        self.navigationController = UINavigationController()
    }
    
    public func start() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController?.setViewControllers([loginViewController], animated: false)
    }
}
