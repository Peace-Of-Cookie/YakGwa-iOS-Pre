//
//  MeetThemes.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Foundation

struct MeetThemesResponseDTO: Codable {
    /// 응답 시간
    let time: String
    /// 응답 상태 코드
    let status: Int
    /// 응답 코드
    let code: String
    /// 응답 메시지
    let message: String
    /// 결과
    let result: MeetThemesResult
    
    struct MeetThemesResult: Codable {
        let meetThemeInfos: [MeetThemeInfo]
        
        struct MeetThemeInfo: Codable {
            /// 테마 Id
            let meetThemeId: Int
            /// 테마 이름
            let name: String
        }
    }
}

extension MeetThemesResponseDTO {
    func toDomain() -> [MeetTheme] {
        result.meetThemeInfos.map {
            MeetTheme(id: $0.meetThemeId, name: $0.name)
        }
    }
}
