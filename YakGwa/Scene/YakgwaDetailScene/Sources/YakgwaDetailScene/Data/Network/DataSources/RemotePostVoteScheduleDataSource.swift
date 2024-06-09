//
//  RemotePostVoteScheduleDataSource.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import Network
import RxSwift

public final class RemotePostVoteScheduleDataSource: BaseRemoteDataSource <YakgwaDetailAPI>, RemotePostVoteScheduleDataSourceProtocol {
    public func postVoteSchedule(userId: Int, meetId: Int, requestDTO: PostVoteSchedulesRequestDTO) -> Single<PostVoteSchedulesResponseDTO> {
        do {
            let jsonData = try JSONEncoder().encode(requestDTO)
            return request(
                .postScheduleVote(userId: userId, meetId: meetId, times: jsonData)
            ).map(PostVoteSchedulesResponseDTO.self)
        } catch {
            return .error(error)
        }
    }
}
