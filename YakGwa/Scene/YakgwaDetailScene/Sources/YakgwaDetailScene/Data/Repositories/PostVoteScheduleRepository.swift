//
//  PostVoteScheduleRepository.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Network
import RxSwift

public final class PostVoteScheduleRepository: PostVoteScheduleRepositoryProtocol {
    private let remoteDataSource: RemotePostVoteScheduleDataSourceProtocol
    
    public init(remoteDataSource: RemotePostVoteScheduleDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func postVoteSchedule(userId: Int, meetId: Int, requestDTO: PostVoteSchedulesRequestDTO) -> Single<PostVoteSchedulesResponseDTO> {
        remoteDataSource
            .postVoteSchedule(userId: userId, meetId: meetId, requestDTO: requestDTO)
    }
}
