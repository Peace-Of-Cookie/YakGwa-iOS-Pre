//
//  File.swift
//  
//
//  Created by Ekko on 6/6/24.
//

import UIKit
import Common
import Network

final public class CalendarVoteCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    public weak var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {}
    
    public func start(with meetId: Int) {
        let reactor: CalendarVoteReactor = CalendarVoteReactor(
            meetId: meetId,
            fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCase(
                repository: FetchMeetVoteInfoRepository(
                    remoteDataSource: RemoteFetchMeetVoteDataSource())))
        
        let calendarVoteViewController = CalendarVoteViewController(reactor: reactor)
        calendarVoteViewController.coordinator = self
        navigationController?.pushViewController(calendarVoteViewController, animated: true)
    }
    
    func popCalendarVote() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}
