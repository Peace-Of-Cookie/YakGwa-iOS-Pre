//
//  FetchUserVoteStatusRepositoryProtocol.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import RxSwift
import Network

public protocol FetchUserVoteStatusRepositoryProtocol {
    func fetchUserVoteStatus(userId: Int, meetId: Int) -> Single<UserVoteStatus>
}
