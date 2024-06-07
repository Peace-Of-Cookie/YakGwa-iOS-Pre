//
//  UserVoteStatusReactor.swift
//
//
//  Created by Ekko on 6/7/24.
//

import ReactorKit
import Util
import Network

public final class UserVoteStatusReactor: Reactor {
    let fetchUserVoteStatusUseCase: FetchUserVoteStatusUseCaseProtocol
    let fetchMeetInfoUseCase: FetchMeetInfoUseCaseProtocol
    
    public enum Action {
        case viewWillAppeared
    }
    
    public enum Mutation {
        case setUserVoteInfo(UserVoteStatus)
        case setMeetInfo(MeetInfo)
    }
    
    public struct State {
        var meetId: Int
        var userVoteStatus: UserVoteStatus?
        var meetInfo: MeetInfo?
    }
    
    public var initialState: State
    
    public init(
        meetId: Int,
        fetchUserVoteStatusUseCase: FetchUserVoteStatusUseCaseProtocol,
        fetchMeetInfoUseCase: FetchMeetInfoUseCaseProtocol
    ) {
        self.initialState = State(meetId: meetId)
        self.fetchUserVoteStatusUseCase = fetchUserVoteStatusUseCase
        self.fetchMeetInfoUseCase = fetchMeetInfoUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppeared:
            guard let token = AccessTokenManager.readAccessToken() else { return .empty() }
            guard let userId = KeyChainManager.read(key: "userId") else { return .empty() }
            return Observable.concat([
                fetchMeetInfoUseCase.execute(token: token, userId: Int(userId) ?? 0, meetId: currentState.meetId)
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
                    .map { Mutation.setMeetInfo($0) },
                fetchUserVoteStatusUseCase
                    .execute(userId: Int(userId) ?? 4, meetId: currentState.meetId) // TODO: - UserId 교체
                    .asObservable()
                    .map { Mutation.setUserVoteInfo($0) }
            ])
            
//            return fetchUserVoteStatusUseCase
//                .execute(userId: 4, meetId: currentState.meetId) // TODO: - UserId 교체
//                .asObservable()
//                .map { Mutation.setUserVoteInfo($0) }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setUserVoteInfo(let userVoteStatus):
            newState.userVoteStatus = userVoteStatus
        case .setMeetInfo(let meetInfo):
            newState.meetInfo = meetInfo
        }
        return newState
    }
    
}
