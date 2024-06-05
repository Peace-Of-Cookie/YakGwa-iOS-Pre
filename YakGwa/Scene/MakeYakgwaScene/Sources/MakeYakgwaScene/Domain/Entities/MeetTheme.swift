//
//  MeetTheme.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Foundation

/// 테마 엔터티
public struct MeetTheme: Codable, Equatable {
    /// 테마 id
    let id: Int?
    /// 테마 이름
    let name: String?
}
