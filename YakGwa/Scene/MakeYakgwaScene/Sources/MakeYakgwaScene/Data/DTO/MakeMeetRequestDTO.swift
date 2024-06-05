//
//  MakeMeetRequestDTO.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Foundation
import Util

/// 약속 생성 요청 DTO
/// 
/*
{
  "meetName": "string",
  "meetDescription": "string",
  "meetThemeId": 0,
  "places": " [강남역, 건대입구역] ",
  "voteDateRange": {
    "start": "2024-06-04",
    "end": "2024-06-04"
  },
  "voteTimeRange": {
    "start": "18:00",
    "end": "20:00"
  },
  "endVoteHour": 0
}
*/
public struct MakeMeetRequestDTO: Codable {
    let meetName: String
    let meetDescription: String
    let meetThemeId: Int
    let places: [String]
    let voteDateRange: DateRange
    let voteTimeRange: TimeRange
    let endVoteHour: Int
    
    struct DateRange: Codable {
        let start: String
        let end: String
    }
    
    struct TimeRange: Codable {
        let start: String
        let end: String
    }
    
    init(from entity: Yakgwa) {
        self.meetName = entity.yakgwaTitle ?? ""
        self.meetDescription = entity.yakgwaDescription ?? ""
        self.meetThemeId = entity.yakgwaTheme ?? 0
        self.places = entity.yakgwaLocation
        self.voteDateRange = DateRange(start: entity.yakgwaStartDate?.toString(format: "yyyy-MM-dd") ?? "",
                                       end: entity.yakgwaEndDate?.toString(format: "yyyy-MM-dd") ?? "")
        self.voteTimeRange = TimeRange(start: entity.yakgwaStartTime?.toString(format: "HH:mm") ?? "",
                                       end: entity.yakgwaEndTime?.toString(format: "HH:mm") ?? "")
        self.endVoteHour = entity.expiredDate ?? 0
    }
}


