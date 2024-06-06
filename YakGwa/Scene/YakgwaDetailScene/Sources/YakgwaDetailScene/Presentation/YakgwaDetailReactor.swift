//
//  YakgwaDetailReactor.swift
//
//
//  Created by Ekko on 6/6/24.
//

import ReactorKit
import Util
import Network

public final class YakgwaDetailReactor: Reactor {
    // MARK: - Properties
    let fetchMeetInfoUseCase: FetchMeetInfoUseCaseProtocol
    
    let disposeBag: DisposeBag = DisposeBag()
    
    public enum Action {
        case viewWillAppeared
        case voteButtonTapped
    }
    
    public enum Mutation {
        case setInfo(MeetInfo)
        case navigateToVoteScene(Int)
    }
    
    public struct State {
        /// 모임 id
        var meetId: Int
        /// 모임 정보 (will be deprecated)
        var meetInfo: MeetInfo?
        /// 투표 화면 이동
        @Pulse var shouldNavigateToVoteScene: Int = 0
    }
    
    public var initialState: State
    
    init(
        meetId: Int,
        fetchMeetInfoUseCase: FetchMeetInfoUseCaseProtocol
    ) {
        self.initialState = State(meetId: meetId)
        self.fetchMeetInfoUseCase = fetchMeetInfoUseCase
        print("모임 아이디: \(meetId)")
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppeared:
            guard let token = AccessTokenManager.readAccessToken() else { return .empty() }
            guard let userId = KeyChainManager.read(key: "userId") else { return .empty() }
            return fetchMeetInfoUseCase.execute(token: token, userId: Int(userId) ?? 0, meetId: currentState.meetId)
                .map { (responseDTO: MeetInfoResponseDTO) -> MeetInfo in
                    let meetInfo = responseDTO.result.meetInfo
                    let participantInfo = responseDTO.result.participantInfo
                    return MeetInfo(
                        id: meetInfo.meetId,
                        themeName: meetInfo.meetThemeName,
                        name: meetInfo.meetName,
                        description: meetInfo.meetDescription,
                        expiredAfter: meetInfo.leftInviteTime,
                        participantsInfo: participantInfo.map {
                            MeetInfo.ParticipantInfo(
                                role: $0.meetRole,
                                entryId: $0.entryId,
                                profileImageUrl: $0.imageUrl
                            )
                        }
                    )
                }
                .asObservable()
                .map { Mutation.setInfo($0) }
                .catch { error in
                    print("Error occurred: \(error)")
                    return Observable.empty()
                }
            
        case .voteButtonTapped:
            return .just(.navigateToVoteScene(currentState.meetId))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setInfo(let meetInfo):
            newState.meetInfo = meetInfo
        case .navigateToVoteScene(let meetId):
            newState.shouldNavigateToVoteScene = meetId
            
        }
        return newState
    }
}
