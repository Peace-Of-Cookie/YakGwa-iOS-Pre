//
//  File.swift
//  
//
//  Created by Ekko on 6/6/24.
//

import Network
import RxSwift

public protocol FetchMeetVoteInfoUseCaseProtocol {
    func execute(meetId: Int) -> Single<MeetVoteInfo>
}

public final class FetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCaseProtocol {
    private let repository: FetchMeetVoteInfoRepositoryProtocol
    
    public init(repository: FetchMeetVoteInfoRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(meetId: Int) -> Single<MeetVoteInfo> {
        repository.fetchMeetVoteInfo(meetId: meetId)
    }
}
