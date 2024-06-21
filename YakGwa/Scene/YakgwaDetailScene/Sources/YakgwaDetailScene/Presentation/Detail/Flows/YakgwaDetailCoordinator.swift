//
//  YakgwaDetailCoordinator.swift
//
//
//  Created by Ekko on 6/6/24.
//

import UIKit
import CoreKit
import Network

final public class YakgwaDetailCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    public weak var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() { }
    
    public func start(with meetId: Int) {
        let reactor: YakgwaDetailReactor = YakgwaDetailReactor(
            meetId: meetId,
            fetchMeetInfoUseCase: FetchMeetInfoUseCase(
                repository: FetchMeetInfoRepository(
                    remoteDataSource: RemoteFetchMeetInfoDataSource()))
        )
        let yakgwaDetailViewController = YakgwaDetailViewController(reactor: reactor)
        yakgwaDetailViewController.coordinator = self
        navigationController?.pushViewController(yakgwaDetailViewController, animated: true)
    }
    
    func popYakgwaDetail() {
        parentCoordinator?.removeChildCoordinator(self)
    }
    
    func navigateToVoteScene(meetId: Int) {
        guard let navigationController = navigationController else { return }
        let calendarVoteCoordinator = CalendarVoteCoordinator(navigationController: navigationController)
        calendarVoteCoordinator.parentCoordinator = self
        self.addChildCoordinator(calendarVoteCoordinator)
        calendarVoteCoordinator.start(with: meetId)
    }
}
