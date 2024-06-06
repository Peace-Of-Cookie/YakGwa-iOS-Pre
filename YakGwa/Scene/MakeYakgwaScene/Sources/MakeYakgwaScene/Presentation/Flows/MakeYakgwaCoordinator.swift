//
//  MakeYakgwaCoordinator.swift
//
//
//  Created by Ekko on 6/3/24.
//

import UIKit
import Common
import YakgwaDetailScene

final public class MakeYakgwaCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    public weak var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        
        let makeYakgwaReactor: MakeYakgwaReactor = MakeYakgwaReactor(
            fetchThemeUseCase: FetchMeetThemesUseCase(
                repository: FetchThemeRepository(
                    remoteDataSource: RemoteFetchThemeDataSource())),
            createMeetUseCase: CreateMeetUseCase(
                repository: CreateMeetRepository(
                    remoteDataSource: RemoteCreateMeetDataSource())))
        
        let makeYakgwaViewController = MakeYakgwaViewController(reactor: makeYakgwaReactor)
        makeYakgwaViewController.coordinator = self
        
        navigationController?.pushViewController(makeYakgwaViewController, animated: true)
    }
    
    func popMakeYakgwa() {
        parentCoordinator?.removeChildCoordinator(self)
    }
    
    
    func moveToYakgwaDetail(with meetId: Int) {
        guard let navigationController = navigationController,
              let homeCoordinator = parentCoordinator as? Coordinator else { return }
        
        let yakgwaDetailCoordinator = YakgwaDetailCoordinator(navigationController: navigationController)
        yakgwaDetailCoordinator.parentCoordinator = homeCoordinator
        
        // HomeCoordinator에 YakgwaDetailCoordinator 추가
        homeCoordinator.addChildCoordinator(yakgwaDetailCoordinator)
        yakgwaDetailCoordinator.start(with: meetId)
        
        // MakeYakgwaCoordinator를 HomeCoordinator의 자식 목록에서 제거
        homeCoordinator.removeChildCoordinator(self)
        
        // 네비게이션 스택에서 MakeYakgwaViewController 제거
        navigationController.viewControllers.removeAll { $0 is MakeYakgwaViewController }
    }
}
