//
//  RemotePostVoteScheduleDataSourceProtocol.swift
//
//
//  Created by Ekko on 6/7/24.
//

import RxSwift

public protocol RemotePostVoteScheduleDataSourceProtocol {
    func postVoteSchedule(userId: Int, meetId: Int, requestDTO: PostVoteSchedulesRequestDTO) -> Single<PostVoteSchedulesResponseDTO>
}
