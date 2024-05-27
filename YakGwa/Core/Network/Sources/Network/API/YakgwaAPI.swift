//
//  File.swift
//  
//
//  Created by Kim Dongjoo on 5/22/24.
//

import Foundation

import Moya

public protocol YakgwaAPI: TargetType {
    var domain: YakgwaDomain { get }
    var urlPath: String { get }
    var errorMap: [Int: YakgwaError] { get }
}

extension YakgwaAPI {
    public var baseURL: URL {
        return URL(string: "http://43.202.47.80:8081/api/v1")!
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/login"
        case .logout:
            return "/logout"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .logout:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .login:
            return .requestPlain
        case .logout:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

public enum YakgwaDomain: String {
    case login
    case vote
}

extension YakgwaDomain {
    
}

extension YakgwaDomain {
    var path: String {
        switch self {
        case .login:
            return "/auth"
        case .vote:
            return "/vote"
        }
    }
}
