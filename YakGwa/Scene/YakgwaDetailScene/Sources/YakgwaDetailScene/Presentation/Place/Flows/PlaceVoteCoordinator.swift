//
//  File.swift
//
//
//  Created by Ekko on 6/7/24.
//

import UIKit
import Common

final public class PlaceVoteCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    public weak var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() { }
    
    public func start(with meetId: Int) {
        let reactor: PlaceVoteViewReactor = PlaceVoteViewReactor(
            meetId: meetId,
            fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCase(
                repository: FetchMeetVoteInfoRepository(
                    remoteDataSource: RemoteFetchMeetVoteDataSource())),
            postVotePlaceUseCase: PostVotePlaceUseCase(
                repository: PostVotePlaceRepositoy(
                    remoteDataSource: RemotePostVotePlaceDataSource())))
        
        let viewController = PlaceVoteViewController(reactor: reactor)
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func navigateToAfterVoteScene(meetId: Int) {
        guard let navigationController = navigationController else { return }
        let userVoteStatusCoordinator = UserVoteStatusCoordinator(navigationController: navigationController)
        userVoteStatusCoordinator.parentCoordinator = self
        self.addChildCoordinator(userVoteStatusCoordinator)
        userVoteStatusCoordinator.start(with: meetId)
    }
    
    func popViewController() {
        parentCoordinator?.removeChildCoordinator(self)
    }
    
}
