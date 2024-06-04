//
//  MakeYakgwaAPI.swift
//  
//
//  Created by Ekko on 6/5/24.
//

import Foundation

import Network

public enum MakeYakgwaAPI {
    /// 저장된 모임의 테마 전체 조회
    case fetchMeetThemes(token: String)
    case createYakgwa(token: String, userId: Int, body: Data)
}

extension MakeYakgwaAPI: YakgwaAPI {
    public var domain: YakgwaDomain {
        switch self {
        case .fetchMeetThemes:
            return .none
        case .createYakgwa:
            return .user
        }
    }
    
    public var urlPath: String {
        switch self {
        case .fetchMeetThemes:
            return "/meetThemes"
        case .createYakgwa:
            return "/meets"
        }
    }
    
    public var headers: [String: String]? {
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        switch self {
        case let .fetchMeetThemes(token), let .createYakgwa(token, _, _):
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMeetThemes:
            return .get
        case .createYakgwa:
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchMeetThemes:
            return .requestPlain
        case let .createYakgwa(_, userId, body):
            return .requestCompositeData(bodyData: body, urlParameters: ["userId": userId])
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
