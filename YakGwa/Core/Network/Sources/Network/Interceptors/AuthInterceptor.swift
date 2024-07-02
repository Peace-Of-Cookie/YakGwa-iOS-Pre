//
//  File.swift
//  
//
//  Created by Kim Dongjoo on 7/2/24.
//

import Foundation
import Moya
import Alamofire
import Security
import RxSwift

final class AuthInterceptor: RequestInterceptor {
    static let shared = AuthInterceptor()
    
    private let disposeBag = DisposeBag()
    
    private init() { }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix("http://43.202.47.80:8081/api/v1") == true,
              let accessToken = getAuthToken()
        else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        print("adator 적용 \(urlRequest.headers)")
        completion(.success(urlRequest))
    }
    
//    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
//        print("retry 진입")
//        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
//            completion(.doNotRetryWithError(error))
//            return
//        }
//        
//        let refreshTokenDataSource: RemoteRefreshTokenDataSourceProtocol = RefreshTokenDataSource()
//        
//        guard let refreshToken = getAuthToken(key: "refreshToken") else {
//            completion(.doNotRetryWithError(error))
//            return
//        }
//        refreshTokenDataSource.refreshToken(refreshToken: refreshToken)
//            .asObservable()
//            .map { $0.result.tokenSet }
//            .subscribe(onNext: { [weak self] tokenSet in
//                self?.updateAuthToken(value: tokenSet.accessToken)
//                self?.updateAuthToken(key: "refreshToken", value: tokenSet.refreshToken)
//                
//                var request = request.request
//                request?.setValue("Bearer \(tokenSet.accessToken)", forHTTPHeaderField: "Authorization")
//                completion(.retryWithDelay(0.0))
//            }, onError: { error in
//                completion(.doNotRetryWithError(error))
//            })
//            .disposed(by: disposeBag)
//    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        print("retry 진입")
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        refreshTokens { [weak self] success in
            guard let self = self, success, let accessToken = self.getAuthToken() else {
                completion(.doNotRetryWithError(error))
                return
            }
            
            var request = request.request
            request?.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            completion(.retryWithDelay(0.0))
        }
    }
    
    private func refreshTokens(completion: @escaping (Bool) -> Void) {
        let refreshTokenDataSource: RemoteRefreshTokenDataSourceProtocol = RefreshTokenDataSource()
        
        guard let refreshToken = getAuthToken(key: "refreshToken") else {
            completion(false)
            return
        }
        
        refreshTokenDataSource.refreshToken(refreshToken: refreshToken)
            .asObservable()
            .map { $0.result.tokenSet }
            .subscribe(onNext: { [weak self] tokenSet in
                guard let self = self else {
                    completion(false)
                    return
                }
                self.updateAuthToken(value: tokenSet.accessToken)
                self.updateAuthToken(key: "refreshToken", value: tokenSet.refreshToken)
                completion(true)
            }, onError: { error in
                completion(false)
            })
            .disposed(by: disposeBag)
    }
}

extension AuthInterceptor {
    func getAuthToken(key: String = "accessToken") -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
    
    func updateAuthToken(key: String = "accessToken", value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        return status == errSecSuccess
    }
}
