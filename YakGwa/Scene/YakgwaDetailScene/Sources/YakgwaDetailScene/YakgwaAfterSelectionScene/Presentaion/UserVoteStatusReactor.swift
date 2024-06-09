//
//  UserVoteStatusReactor.swift
//
//
//  Created by Ekko on 6/7/24.
//
import Foundation
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
        
        // UI 바인딩 값
        var meetTheme: String?
        var meetName: String?
        var meetDescription: String?
        var meetVotedTime: [String]?
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
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setUserVoteInfo(let userVoteStatus):
            newState.userVoteStatus = userVoteStatus
            newState.meetVotedTime = userVoteStatus.scheduleVoteInfos.map { formatDateRange(startDate: $0.startDate, endDate: $0.endDate) ?? "" }
        case .setMeetInfo(let meetInfo):
            newState.meetInfo = meetInfo
            newState.meetTheme = meetInfo.themeName
            newState.meetName = meetInfo.name
            newState.meetDescription = meetInfo.description
        }
        return newState
    }
    
}

extension UserVoteStatusReactor {
    private func formatDateRange(startDate: String, endDate: String) -> String? {
        let inputDateFormat = "yyyy-MM-dd HH:mm"
        let outputDateFormat = "yy/MM/dd H시"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let start = dateFormatter.date(from: startDate), let end = dateFormatter.date(from: endDate) else {
            return nil
        }
        
        dateFormatter.dateFormat = outputDateFormat
        
        let formattedStart = dateFormatter.string(from: start)
        
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "H"
        hourFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let formattedEndHour = hourFormatter.string(from: end)
        
        return "\(formattedStart) - \(formattedEndHour)시"
    }
}
