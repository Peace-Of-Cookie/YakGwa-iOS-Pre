//
//  SceneDelegate.swift
//  YakGwa
//
//  Created by Ekko on 5/19/24.
//

import UIKit

import SceneKit
import LoginScene
import SplashScene
import KakaoSDKAuth

import YakgwaDetailScene

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        self.window = window
        let appCoordinator = AppCoordinator(window: window)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }
    
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        
//        let window = UIWindow(windowScene: windowScene)
//        
//        
////        let reactor: PlaceVoteViewReactor = PlaceVoteViewReactor(
////            fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCase(
////                repository: FetchMeetVoteInfoRepository(
////                    remoteDataSource: RemoteFetchMeetVoteDataSource())),
////            postVotePlaceUseCase: PostVotePlaceUseCase(
////                repository: PostVotePlaceRepositoy(
////                    remoteDataSource: RemotePostVotePlaceDataSource())))
////
////        let placeVoteViewController = PlaceVoteViewController(reactor: reactor)
////        
////         스케줄 테스트
////        let reactor: CalendarVoteReactor = CalendarVoteReactor(
////            fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCase(
////                repository: FetchMeetVoteInfoRepository(
////                    remoteDataSource: RemoteFetchMeetVoteDataSource())),
////            postVoteScheduleUseCase: PostVoteScheduleUseCase(repository: PostVoteScheduleRepository(remoteDataSource: RemotePostVoteScheduleDataSource())))
////        
////         let calendarVoteViewController = CalendarVoteViewController(reactor: reactor)
////        
////         투표 현황 테스트
////        let reactor: UserVoteStatusReactor = UserVoteStatusReactor(
////            meetId: 65,
////            fetchUserVoteStatusUseCase: FetchUserVoteStatusUseCase(
////                repository: FetchUserVoteStatusRepository(
////                    remoteDataSource: RemoteFetchUserVoteStatusDataSource())),
////            fetchMeetInfoUseCase: FetchMeetInfoUseCase(
////                        repository: FetchMeetInfoRepository(remoteDataSource: RemoteFetchMeetInfoDataSource()))
////        )
////        
////        let voteViewController = UserVoteStatusViewController(reactor: reactor)
//        
//        let viewController = TestUIViewController()
//        
//        window.rootViewController = viewController
//        self.window = window
//        window.makeKeyAndVisible()
//    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                let _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}

