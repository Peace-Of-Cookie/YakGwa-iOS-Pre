//
//  KakaoLoginService.swift
//
//
//  Created by Kim Dongjoo on 5/29/24.
//

import Foundation

import Common

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

protocol LoginServiceType {
    func requestKakaoLogin() -> Observable<Bool>
}

class LoginService: LoginServiceType {
    func requestKakaoLogin() -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        observer.onError(error)
                    } else {
                        /// 카카오 로그인 토큰
                        let token = oauthToken?.accessToken
                        print("카카오 로그인 토큰: \(token)")
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                }
            } else {
                observer.onError(
                    NSError(domain: "KakaoLoginService",
                            code: 0,
                            userInfo: [
                                NSLocalizedDescriptionKey: "KakaoTalk login is not available."
                            ]
                           )
                )
            }
            return Disposables.create()
        }
    }
}
