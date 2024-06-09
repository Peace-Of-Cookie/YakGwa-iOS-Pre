//
//  FetchUserVoteStatusUseCase.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import RxSwift
import Network

public protocol FetchUserVoteStatusUseCaseProtocol {
    func execute(userId: Int, meetId: Int) -> Single<UserVoteStatus>
}

final public class FetchUserVoteStatusUseCase: FetchUserVoteStatusUseCaseProtocol {
    private let repository: FetchUserVoteStatusRepositoryProtocol
    
    public init(repository: FetchUserVoteStatusRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(userId: Int, meetId: Int) -> Single<UserVoteStatus> {
        return repository.fetchUserVoteStatus(userId: userId, meetId: meetId)
    }
}
