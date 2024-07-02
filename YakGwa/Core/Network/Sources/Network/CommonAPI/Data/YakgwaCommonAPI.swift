//
//  YakgwaCommonAPI.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation

public enum YakgwaCommonAPI {
    /// 로그인 Access Token 갱신
    case reissue(refreshToken: String)
    /// 모임 상세 정보 조회
    case fetchMeetInfo(token: String, userId: Int, meetId: Int)
}

extension YakgwaCommonAPI: YakgwaAPI {
    public var domain: YakgwaDomain {
        switch self {
        case .reissue:
            return .login
        case .fetchMeetInfo:
            return .none
        }
    }
    
    public var urlPath: String {
        switch self {
        case .reissue:
            return "/reissue"
            
        case let .fetchMeetInfo(_ , userId, meetId):
            return "/users/\(userId)/meets/\(meetId)"
        }
    }
    
    public var headers: [String: String]? {
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        switch self {
        case let .reissue(refreshToken):
            defaultHeaders["refreshToken"] = "Bearer \(refreshToken)"
        case let .fetchMeetInfo(token, _, _):
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
    
    public var method: Moya.Method {
        switch self {
            
        case .reissue:
            return .get
        case .fetchMeetInfo:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .reissue:
            return .requestPlain
        case .fetchMeetInfo:
            return .requestPlain
        }
    }
    
    public var errorMap: [Int: NetworkError] {
        [
            400: .badRequest,
            401: .tokenExpired,
            403: .notFound,
            404: .tooManyRequest,
            500: .internalServerError
        ]
    }
}
