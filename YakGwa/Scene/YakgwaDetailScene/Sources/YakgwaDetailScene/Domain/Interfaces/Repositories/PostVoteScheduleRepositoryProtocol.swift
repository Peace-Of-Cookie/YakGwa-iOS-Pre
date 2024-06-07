//
//  PostVoteScheduleRepositoryProtocol.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import RxSwift
import Network

public protocol PostVoteScheduleRepositoryProtocol {
    func postVoteSchedule(userId: Int, meetId: Int, requestDTO: PostVoteSchedulesRequestDTO) -> Single<PostVoteSchedulesResponseDTO>
}
