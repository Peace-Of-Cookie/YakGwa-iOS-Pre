//
//  FetchMeetVoteInfoRepositoryProtocol.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation

import RxSwift
import Network

public protocol FetchMeetVoteInfoRepositoryProtocol {
    func fetchMeetVoteInfo(meetId: Int) -> Single<MeetVoteInfo>
}
