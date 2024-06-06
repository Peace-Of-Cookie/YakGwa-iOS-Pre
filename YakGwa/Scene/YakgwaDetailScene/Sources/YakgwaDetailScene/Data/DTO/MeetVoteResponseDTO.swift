//
//  MeetVoteResponseDTO.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation

/*
 {
   "time": "2024-06-06T22:28:38.088075631",
   "status": 200,
   "code": "Success",
   "message": "요청에 성공하였습니다.",
   "result": {
     "placeItems": [
       {
         "candidatePlaceId": 17,
         "name": "수지앤파스타",
         "address": "서울특별시 마포구 상수동 313-1",
         "description": ""
       },
       {
         "candidatePlaceId": 18,
         "name": "트라가 역삼점",
         "address": "서울특별시 강남구 역삼동 628-6",
         "description": ""
       }
     ],
     "timeItems": {
       "timeRange": {
         "start": "00:40",
         "end": "03:40"
       },
       "dateRange": {
         "start": "2024-06-06",
         "end": "2024-06-07"
       }
     }
   }
 }
 */
public struct MeetVoteResponseDTO: Codable {
    let time: String
    let status: Int
    let code: String
    let message: String
    let result: ResultDTO
    
    struct ResultDTO: Codable {
        let placeItems: [PlaceItemDTO]
        let timeItems: TimeItemsDTO
        
        struct PlaceItemDTO: Codable {
            let candidatePlaceId: Int
            let name: String
            let address: String
            let description: String
        }
        
        struct TimeItemsDTO: Codable {
            let timeRange: TimeRangeDTO
            let dateRange: DateRangeDTO
            
            struct TimeRangeDTO: Codable {
                let start: String
                let end: String
            }
            
            struct DateRangeDTO: Codable {
                let start: String
                let end: String
            }
        }
    }
}

extension MeetVoteResponseDTO {
    func toDomain() -> MeetVoteInfo {
        let recommendPlaces = result.placeItems.map { placeItem in
            MeetVoteInfo.RecommendPlace(
                placeId: placeItem.candidatePlaceId,
                name: placeItem.name,
                address: placeItem.address,
                description: placeItem.description
            )
        }
        
        return MeetVoteInfo(
            recommendPlaces: recommendPlaces,
            startDate: result.timeItems.dateRange.start,
            endDate: result.timeItems.dateRange.end,
            startTime: result.timeItems.timeRange.start,
            endTime: result.timeItems.timeRange.end
        )
    }
}


