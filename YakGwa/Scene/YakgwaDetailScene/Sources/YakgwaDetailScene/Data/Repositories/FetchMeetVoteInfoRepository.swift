//
//  FetchMeetVoteInfoRepository.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Network
import RxSwift

public final class FetchMeetVoteInfoRepository: FetchMeetVoteInfoRepositoryProtocol {
    private let remoteDataSource: RemoteFetchMeetVoteDataSourceProtocol
    
    public init(remoteDataSource: RemoteFetchMeetVoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchMeetVoteInfo(meetId: Int) -> Single<MeetVoteInfo> {
        remoteDataSource
            .fetchMeetVoteInfo(meetId: meetId)
            .map { $0.toDomain() }
    }
}
