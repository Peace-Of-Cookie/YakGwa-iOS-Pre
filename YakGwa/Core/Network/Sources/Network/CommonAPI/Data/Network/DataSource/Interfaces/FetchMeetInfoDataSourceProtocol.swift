//
//  FetchMeetInfoDataSourceProtocol.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation

import RxSwift

protocol RemoteFetchMeetInfoDataSourceProtocol {
    func fetchMeetInfo(token: String, userId: Int, meetId: Int) -> Single<MeetInfoResponseDTO>
}
