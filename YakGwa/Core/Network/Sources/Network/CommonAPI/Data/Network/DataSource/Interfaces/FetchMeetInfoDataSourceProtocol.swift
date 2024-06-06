//
//  FetchMeetInfoDataSourceProtocol.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation

import RxSwift

public protocol RemoteFetchMeetInfoDataSourceProtocol {
    func fetchMeetInfo(token: String, userId: Int, meetId: Int) -> Single<MeetInfoResponseDTO>
}
