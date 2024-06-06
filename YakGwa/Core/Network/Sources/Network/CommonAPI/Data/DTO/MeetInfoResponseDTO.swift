//
//  MeetInfoResponseDTO.swift
//
//
//  Created by Ekko on 6/6/24.
//

public struct MeetInfoResponseDTO: Codable {
    public let time: String
    public let status: Int
    public let code: String
    public let message: String
    public let result: ResultInfo
    
    public struct ResultInfo: Codable {
        let userMeetRole: String
        let meetInfo: MeetInfo
        
        struct MeetInfo: Codable {
            let meetStatus: String
            let meetId: Int
            let meetThemeName: String
            let meetName: String
            let meetDescription: String
            let leftInviteTime: String
        }
    }
    
    struct ParticipantInfo: Codable {
        let meetRole: String
        let entryId: Int
        let imageUrl: String?
    }
}

/*
 {
   "time": "2024-06-06T15:23:51.760859051",
   "status": 200,
   "code": "Success",
   "message": "요청에 성공하였습니다.",
   "result": {
     "userMeetRole": "INVITER",
     "meetInfo": {
       "meetStatus": "BEFORE_VOTE",
       "meetId": 23,
       "meetThemeName": "데이트",
       "meetName": "치앙마이",
       "meetDescription": "신우석",
       "leftInviteTime": "11:18"
     },
     "participantInfo": [
       {
         "meetRole": "INVITER",
         "entryId": 2,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 4,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 5,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 6,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 7,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 8,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 9,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 10,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 11,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 12,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 13,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 14,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 15,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 16,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 17,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 18,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 19,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 20,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 21,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 22,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 23,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 1,
         "imageUrl": null
       },
       {
         "meetRole": "INVITER",
         "entryId": 3,
         "imageUrl": null
       }
     ]
   }
 }
 */

import Foundation
