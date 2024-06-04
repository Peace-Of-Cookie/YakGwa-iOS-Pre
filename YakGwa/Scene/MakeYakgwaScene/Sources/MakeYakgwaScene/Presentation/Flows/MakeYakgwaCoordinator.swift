//
//  MakeYakgwaCoordinator.swift
//
//
//  Created by Ekko on 6/3/24.
//

import UIKit
import Common

final public class MakeYakgwaCoordinator: Coordinator {
    public var navigationController: UINavigationController?
    public weak var parentCoordinator: Coordinator?
    public var childCoordinators = [Coordinator]()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        
        let makeYakgwaReactor: MakeYakgwaReactor = MakeYakgwaReactor(fetchThemeUseCase: FetchMeetThemesUseCase(repository: MakeYakgwaRepository(remoteDataSource: RemoteFetchThemeDataSource())))
        
        let makeYakgwaViewController = MakeYakgwaViewController(reactor: makeYakgwaReactor)
        makeYakgwaViewController.coordinator = self
        
        navigationController?.pushViewController(makeYakgwaViewController, animated: true)
    }
    
    func popMakeYakgwa() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}
