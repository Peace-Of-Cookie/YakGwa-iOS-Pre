//
//  ReissueResponseDTO.swift
//  
//
//  Created by Kim Dongjoo on 7/2/24.
//

public struct ReissueResponseDTO: Codable, Equatable {
    public let time: String
    public let status: Int
    public let code: String
    public let message: String
    public let result: ResultInfo
    
    public struct ResultInfo: Codable, Equatable {
        public let tokenSet: TokenSet
        
        public struct TokenSet: Codable, Equatable {
            public let accessToken: String
            public let refreshToken: String
        }
    }
}
