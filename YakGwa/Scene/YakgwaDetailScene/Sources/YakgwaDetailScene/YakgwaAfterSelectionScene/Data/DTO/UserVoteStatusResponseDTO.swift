//
//  UserVoteStatusResponseDTO.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation
/*
 {
   "time": "2024-06-07T19:42:03.042896505",
   "status": 200,
   "code": "Success",
   "message": "요청에 성공하였습니다.",
   "result": {
     "voteStatus": "VOTE",
     "myPlaceVoteInfo": [
       {
         "name": "둥글",
         "address": "서울특별시 강남구 삼성동 142-26 13층"
       }
     ],
     "myTimeVoteInfo": [
       {
         "start": "2024-06-07 10:00",
         "end": "2024-06-07 11:00"
       },
       {
         "start": "2024-06-07 11:00",
         "end": "2024-06-07 12:00"
       },
       {
         "start": "2024-06-07 12:00",
         "end": "2024-06-07 13:00"
       }
     ]
   }
 }
 */
public struct UserVoteStatusResponseDTO: Codable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: ResultDTO
    
    struct ResultDTO: Codable {
        let voteStatus: String
        let myPlaceVoteInfo: [PlaceVoteInfoDTO]
        let myTimeVoteInfo: [TimeVoteInfoDTO]
        
        struct PlaceVoteInfoDTO: Codable {
            let name: String
            let address: String
        }
        
        struct TimeVoteInfoDTO: Codable {
            let start: String
            let end: String
        }
    }
}

extension UserVoteStatusResponseDTO {
    func toDomain() -> UserVoteStatus {
        return UserVoteStatus(
            placeVoteInfos: result.myPlaceVoteInfo
                .map { UserVoteStatus.PlaceVoteInfo(
                    placeName: $0.name,
                    placeAddress: $0.address)
                },
            scheduleVoteInfos: result.myTimeVoteInfo
                .map { UserVoteStatus.ScheduleVoteInfo(
                    startDate: $0.start,
                    endDate: $0.end)
                }
        )
    }
}
