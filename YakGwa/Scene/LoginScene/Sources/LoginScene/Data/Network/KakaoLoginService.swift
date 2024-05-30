//
//  KakaoLoginService.swift
//
//
//  Created by Kim Dongjoo on 5/29/24.
//

import Foundation

import Common
import Network
import Util

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

protocol LoginServiceType {
    func requestKakaoLogin() -> Observable<Bool>
}

class LoginService: LoginServiceType {
    private let apiDataSource: BaseRemoteDataSource<LoginAPI>
    private let disposeBag = DisposeBag()
    
    init(apiDataSource: BaseRemoteDataSource<LoginAPI>) {
        self.apiDataSource = apiDataSource
    }
    
    func requestKakaoLogin() -> Observable<Bool> {
            return Observable<Bool>.create { observer in
                if UserApi.isKakaoTalkLoginAvailable() {
                    UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            observer.onError(error)
                        } else if let token = oauthToken?.accessToken {
                            let body: [String: Any] = ["loginType": "KAKAO"]
                            guard let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                                observer.onError(NSError(domain: "KakaoLoginService",
                                                         code: 0,
                                                         userInfo: [NSLocalizedDescriptionKey: "Failed to serialize body."]))
                                return
                            }
                            
                            // Call the login API using the BaseRemoteDataSource
                            self.apiDataSource.request(.login(token: token, body: bodyData))
                                .subscribe(onSuccess: { response in
                                    do {
                                        let loginResponse = try JSONDecoder().decode(LoginResponseDTO.self, from: response.data)
                                        let tokenSet = loginResponse.result.tokenSet
                                        
                                        print("토큰토큰: \(tokenSet.accessToken)")
                                        
                                        AccessTokenManager.saveAccessToken(token: tokenSet.accessToken)
                                        AccessTokenManager.saveRefreshToken(token: tokenSet.refreshToken)
                                        
                                        observer.onNext(true)
                                        observer.onCompleted()
                                    } catch {
                                        observer.onError(error)
                                    }
                                }, onFailure: { error in
                                    observer.onError(error)
                                })
                                .disposed(by: self.disposeBag)
                        }
                    }
                } else {
                    observer.onError(
                        NSError(domain: "KakaoLoginService",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "KakaoTalk login is not available."]))
                }
                return Disposables.create()
            }
        }
}


