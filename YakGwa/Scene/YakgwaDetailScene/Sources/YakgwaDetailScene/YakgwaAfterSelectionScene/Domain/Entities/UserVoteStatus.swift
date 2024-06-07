//
//  UserVoteStatus.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

public struct UserVoteStatus: Equatable {
    let placeVoteInfos: [PlaceVoteInfo]
    let scheduleVoteInfos: [ScheduleVoteInfo]
    
    struct PlaceVoteInfo: Equatable {
        let placeName: String
        let placeAddress: String
    }
    
    struct ScheduleVoteInfo: Equatable {
        let startDate: String
        let endDate: String
    }
}
