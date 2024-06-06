//
//  RemoteFetchMeetVoteDataSourceProtocol.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation

import Network

import RxSwift

public protocol RemoteFetchMeetVoteDataSourceProtocol {
    func fetchMeetVoteInfo(meetId: Int) -> Single<MeetVoteResponseDTO>
}
