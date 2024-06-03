//
//  HomeCoordinator.swift
//
//
//  Created by Kim Dongjoo on 6/3/24.
//

import UIKit
import Common
import MakeYakgwaScene

final public class HomeCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    public weak var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    private let window: UIWindow
    
    public init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    public func start() {
        let reactor: HomeReactor = HomeReactor()
        let homeViewController = HomeViewController(reactor: reactor)
        homeViewController.coordinator = self
        
        navigationController?.setViewControllers([homeViewController], animated: false)
        
        window.rootViewController = homeViewController
        window.makeKeyAndVisible()
    }
    
    func moveToMakeYakgwa() {
        let makeYakgwaCoordinator = MakeYakgwaCoordinator(navigationController: self.navigationController!)
        makeYakgwaCoordinator.parentCoordinator = self
        parentCoordinator?.addChildCoordinator(makeYakgwaCoordinator)
        makeYakgwaCoordinator.start()
    }
}
