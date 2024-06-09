//
//  PostVotePlacesResponseDTO.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation
/*
 {
   "time": "2024-06-07T06:29:53.157Z",
   "status": 0,
   "code": "string",
   "message": "string",
 }
 */

public struct PostVotePlacesResponseDTO: Codable, Equatable {
    public let time: String
    public let status: Int
    public let code: String
    public let message: String
}
