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
    var errorMap: [Int: NetworkError] { get }
}

extension YakgwaAPI {
    public var baseURL: URL {
        return URL(string: "http://43.202.47.80:8081/api/v1")!
    }
    
    public var path: String {
        domain.asURLString + urlPath
    }
    
    var headers: [String: String]? {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

/// API Domain
public enum YakgwaDomain: String {
    case login
    case vote
}

extension YakgwaDomain {
    var asURLString: String {
        "\(self.path)"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth"
        case .vote:
            return "/vote"
        }
    }
}
