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
    case postScheduleVote(userId: Int, meetId: Int, times: Data)
    case postPlaceVote(userId: Int, meetId: Int, places: Data)
}

extension YakgwaDetailAPI: YakgwaAPI {
    public var domain: YakgwaDomain {
        switch self {
        case .fetchMeetVoteInfo:
            return .none
        case .postScheduleVote:
            return .none
        case .postPlaceVote:
            return .none
        }
    }
    
    public var urlPath: String {
        switch self {
        case let .fetchMeetVoteInfo(meetId):
            return "/meets/\(meetId)/vote/items"
        case let .postScheduleVote(userId, meetId, _):
            return "/users/\(userId)/meets/\(meetId)/vote/schedules"
        case let .postPlaceVote(userId, meetId, _):
            return "/users/\(userId)/meets/\(meetId)/vote/places"
        }
    }
    
    public var headers: [String: String]? {
        var defaultHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        switch self {
        case let .fetchMeetVoteInfo(meetId):
//            guard let token = AccessTokenManager.readAccessToken() else { return defaultHeaders }
            let token = "eyJhbGciOiJIUzUxMiJ9.eyJhdXRoSWQiOiIzNDcwMzk2ODMyIiwic3ViIjoiMzQ3MDM5NjgzMiIsImV4cCI6MTcxODI5MTMyMiwiaWF0IjoxNzE3Njg2NTIyfQ.iaMhkIjZDUUY5542FfpGQB4KH22zJEv5_vMN00J3OlUyy_2RxPIk8vXKnfRvS4UsE1GXEu6Rulxq-RBMO2L5_g"
            defaultHeaders["Authorization"] = "Bearer \(token)"
        case .postScheduleVote:
            // guard let token = AccessTokenManager.readAccessToken() else { return defaultHeaders }
            let token = "eyJhbGciOiJIUzUxMiJ9.eyJhdXRoSWQiOiIzNDcwMzk2ODMyIiwic3ViIjoiMzQ3MDM5NjgzMiIsImV4cCI6MTcxODI5MTMyMiwiaWF0IjoxNzE3Njg2NTIyfQ.iaMhkIjZDUUY5542FfpGQB4KH22zJEv5_vMN00J3OlUyy_2RxPIk8vXKnfRvS4UsE1GXEu6Rulxq-RBMO2L5_g"
            defaultHeaders["Authorization"] = "Bearer \(token)"
        case .postPlaceVote:
            // guard let token = AccessTokenManager.readAccessToken() else { return defaultHeaders }
            let token = "eyJhbGciOiJIUzUxMiJ9.eyJhdXRoSWQiOiIzNDcwMzk2ODMyIiwic3ViIjoiMzQ3MDM5NjgzMiIsImV4cCI6MTcxODI5MTMyMiwiaWF0IjoxNzE3Njg2NTIyfQ.iaMhkIjZDUUY5542FfpGQB4KH22zJEv5_vMN00J3OlUyy_2RxPIk8vXKnfRvS4UsE1GXEu6Rulxq-RBMO2L5_g"
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMeetVoteInfo:
            return .get
        case .postScheduleVote:
            return .post
        case .postPlaceVote:
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchMeetVoteInfo:
            return .requestPlain
        case let .postScheduleVote(_ ,_ , body):
            return .requestData(body)
        case let .postPlaceVote(_ ,_ , body):
            return .requestData(body)
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
