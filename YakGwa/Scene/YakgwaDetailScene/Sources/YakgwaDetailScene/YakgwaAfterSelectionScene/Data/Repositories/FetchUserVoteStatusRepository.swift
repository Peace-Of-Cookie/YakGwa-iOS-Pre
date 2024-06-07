//
//  FetchUserVoteStatusRepository.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import RxSwift
import Network

public class FetchUserVoteStatusRepository: FetchUserVoteStatusRepositoryProtocol {
    private let remoteDataSource: RemoteFetchUserVoteStatusDataSourceProtocol
    
    public init(remoteDataSource: RemoteFetchUserVoteStatusDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchUserVoteStatus(userId: Int, meetId: Int) -> Single<UserVoteStatus> {
        return remoteDataSource
            .fetchUserVoteStatus(userId: userId, meetId: meetId)
            .map { $0.toDomain() }
    }
}
