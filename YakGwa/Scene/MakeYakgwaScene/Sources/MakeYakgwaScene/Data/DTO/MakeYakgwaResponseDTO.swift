//
//  MakeMeetResponseDTO.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Foundation
/*
 {
   "time": "2024-06-05T06:28:57.172Z",
   "status": 0,
   "code": "string",
   "message": "string",
   "result": {}
 }
 */
struct MakeMeetResponseDTO: Codable {
    /// 응답 시간
    let time: String
    /// 응답 상태 코드
    let status: Int
    /// 응답 코드
    let code: String
    /// 응답 메시지
    let message: String
    /// 결과
    let result: MakeMeetResult
    
    struct MakeMeetResult: Codable {
        let yakgwaId: Int
        let name: String
        let imageUrl: String
        let price: Int
        let description: String
        let ingredients: [String]
    }
}
