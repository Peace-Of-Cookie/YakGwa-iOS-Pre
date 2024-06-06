//
//  MeetInfo.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation

/// 모임 정보 엔터티
public struct MeetInfo: Equatable {
    /// 모임 id
    let id: Int?
    /// 테마 명
    let themeName: String?
    /// 모임 이름
    let name: String?
    /// 모임 설명
    let description: String?
    /// 투표 종료 시간
    let expiredAfter: LeftInviteTime?
    /// 참여자 정보
    let participantsInfo: [ParticipantInfo]?
    
    struct LeftInviteTime: Equatable {
        let hour: Int = 0
        let minute: Int = 0
        let second: Int = 0
        let nano: Int = 0
    }
    
    struct ParticipantInfo: Equatable {
        let role: Int?
        let entryId: String?
        let profileImageUrl: String?
    }
}
