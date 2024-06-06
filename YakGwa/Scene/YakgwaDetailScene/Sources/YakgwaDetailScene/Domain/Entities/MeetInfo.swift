//
//  MeetInfo.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation
import Network

/// 모임 정보 엔터티
public struct MeetInfo: Equatable, Codable {
    /// 모임 id
    let id: Int?
    /// 테마 명
    let themeName: String?
    /// 모임 이름
    let name: String?
    /// 모임 설명
    let description: String?
    /// 투표 종료 시간
    let expiredAfter: String?
    /// 참여자 정보
    let participantsInfo: [ParticipantInfo]?
    
    struct ParticipantInfo: Equatable, Codable {
        let role: String?
        let entryId: Int?
        let profileImageUrl: String?
    }
}
