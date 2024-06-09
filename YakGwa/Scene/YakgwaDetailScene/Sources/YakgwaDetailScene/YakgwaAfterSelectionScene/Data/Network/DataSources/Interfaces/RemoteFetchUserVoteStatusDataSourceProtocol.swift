//
//  RemoteFetchUserVoteStatusDataSourceProtocol.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import RxSwift
import Network

public protocol RemoteFetchUserVoteStatusDataSourceProtocol {
    func fetchUserVoteStatus(userId: Int, meetId: Int) -> Single<UserVoteStatusResponseDTO>
}
