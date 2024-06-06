//
//  MeetInfo.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation
import Network

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
    let expiredAfter: String?
    /// 참여자 정보
    let participantsInfo: [ParticipantInfo]?
    
    struct ParticipantInfo: Equatable {
        let role: Int?
        let entryId: String?
        let profileImageUrl: String?
    }
    
//    public init(with: MeetInfoResponseDTO) {
//        sel
//        self.themeName = with.themeName
//        self.name = with.name
//        self.description = with.description
//        self.expiredAfter = with.expiredAfter
//        self.participantsInfo = with.participantsInfo?.map { ParticipantInfo(with: $0) }
//    }
}
