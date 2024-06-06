//
//  FetchMeetInfoDataSource.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation

import RxSwift

public final class RemoteFetchMeetInfoDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteFetchMeetInfoDataSourceProtocol {
    public func fetchMeetInfo(token: String, userId: Int, meetId: Int) -> Single<MeetInfoResponseDTO> {
        request(
            .fetchMeetInfo(token: token, userId: userId, meetId: meetId)
        ).map(MeetInfoResponseDTO.self)
    }
}
