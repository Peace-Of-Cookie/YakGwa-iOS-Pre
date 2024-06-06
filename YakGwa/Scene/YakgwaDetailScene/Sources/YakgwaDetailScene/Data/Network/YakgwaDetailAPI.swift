//
//  YakgwaDetailAPI.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation

import Network
import Util

public enum YakgwaDetailAPI {
    case fetchMeetVoteInfo(meetId: Int)
}

extension YakgwaDetailAPI: YakgwaAPI {
    public var domain: YakgwaDomain {
        switch self {
        case .fetchMeetVoteInfo:
            return .none
        }
    }
    
    public var urlPath: String {
        switch self {
        case let .fetchMeetVoteInfo(meetId):
            return "/meets/\(meetId)/vote/items"
        }
    }
    
    public var headers: [String: String]? {
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        switch self {
        case let .fetchMeetVoteInfo(meetId):
            guard let token = AccessTokenManager.readAccessToken() else { return defaultHeaders }
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMeetVoteInfo:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchMeetVoteInfo:
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
