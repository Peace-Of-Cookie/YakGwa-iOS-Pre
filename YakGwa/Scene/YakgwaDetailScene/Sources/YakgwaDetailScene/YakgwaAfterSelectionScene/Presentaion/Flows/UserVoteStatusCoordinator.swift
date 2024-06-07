//
//  UserVoteStatusCoordinator.swift
//
//
//  Created by Ekko on 6/7/24.
//

import UIKit
import Common

final public class UserVoteStatusCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    public weak var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() { }
    
    public func start(with meetId: Int) {
        let reactor: UserVoteStatusReactor = UserVoteStatusReactor(
            meetId: meetId,
            fetchUserVoteStatusUseCase: FetchUserVoteStatusUseCase(
                repository: FetchUserVoteStatusRepository(
                    remoteDataSource: RemoteFetchUserVoteStatusDataSource()))
        )
        
        let viewController = UserVoteStatusViewController(reactor: reactor)
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popViewController() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}
