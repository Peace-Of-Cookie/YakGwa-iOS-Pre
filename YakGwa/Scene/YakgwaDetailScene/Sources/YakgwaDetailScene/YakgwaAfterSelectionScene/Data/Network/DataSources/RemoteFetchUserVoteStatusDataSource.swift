//
//  RemoteFetchUserVoteStatusDataSource.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import RxSwift
import Network

public class RemoteFetchUserVoteStatusDataSource: BaseRemoteDataSource<AfterSelectionAPI>, RemoteFetchUserVoteStatusDataSourceProtocol {
    public func fetchUserVoteStatus(userId: Int, meetId: Int) -> Single<UserVoteStatusResponseDTO> {
        return request(
            .fetchUserVoteStatusInfo(userId: userId, meetId: meetId)
        ).map(UserVoteStatusResponseDTO.self)
    }
}
