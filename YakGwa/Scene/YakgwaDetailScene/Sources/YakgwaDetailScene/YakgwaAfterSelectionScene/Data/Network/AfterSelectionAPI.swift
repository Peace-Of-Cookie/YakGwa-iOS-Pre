//
//  AfterSelectionAPI.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import Network
import Util

public enum AfterSelectionAPI {
    case fetchUserVoteStatusInfo(userId: Int, meetId: Int)
}

extension AfterSelectionAPI: YakgwaAPI {
    public var domain: YakgwaDomain {
        switch self {
        /// 사용자의 투표현황 조회 API
        case .fetchUserVoteStatusInfo:
            return .none
        }
    }
    
    public var urlPath: String {
        switch self {
        case let .fetchUserVoteStatusInfo(userId, meetId):
            return "/users/\(userId)/meets/\(meetId)/vote"
        }
    }
    
    public var headers: [String: String]? {
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        switch self {
        case .fetchUserVoteStatusInfo:
            guard let token = AccessTokenManager.readAccessToken() else { return defaultHeaders }
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchUserVoteStatusInfo:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchUserVoteStatusInfo:
            return .requestPlain
        }
    }
    
    public var errorMap: [Int : NetworkError] {
        [
            400: .badRequest,
            401: .tokenExpired,
            403: .notFound,
            404: .tooManyRequest,
            500: .internalServerError
        ]
    }
}
