//
//  YakgwaDetailCoordinator.swift
//
//
//  Created by Ekko on 6/6/24.
//

import UIKit
import Common

final public class YakgwaDetailCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    public weak var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let reactor: YakgwaDetailReactor = YakgwaDetailReactor(meetId: 0)
        let yakgwaDetailViewController = YakgwaDetailViewController(reactor: reactor)
        yakgwaDetailViewController.coordinator = self
        navigationController?.pushViewController(yakgwaDetailViewController, animated: true)
    }
    
    func popYakgwaDetail() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}
