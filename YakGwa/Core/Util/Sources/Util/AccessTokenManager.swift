//
//  File.swift
//  
//
//  Created by Ekko on 5/30/24.
//

import Foundation

public final class AccessTokenManager {
    /// Access Token을 Keychain에 저장
    public static func saveAccessToken(token: String) {
        KeyChainManager.save(key: "accessToken", value: token)
    }
    
    /// Access Token을 Keychain에서 읽어옴
    public static func readAccessToken() -> String? {
        return KeyChainManager.read(key: "accessToken")
    }
    
    /// Access Token을 Keychain에서 삭제
    public static func deleteAccessToken() {
        KeyChainManager.delete(key: "accessToken")
    }
    
    /// Refresh Token을 Keychain에 저장
    public static func saveRefreshToken(token: String) {
        KeyChainManager.save(key: "refreshToken", value: token)
    }
    
    /// Refresh Token을 Keychain에서 읽어옴
    public static func readRefreshToken() -> String? {
        return KeyChainManager.read(key: "refreshToken")
    }
    
    /// Refresh Token을 Keychain에서 삭제
    public static func deleteRefreshToken() {
        KeyChainManager.delete(key: "refreshToken")
    }
}
