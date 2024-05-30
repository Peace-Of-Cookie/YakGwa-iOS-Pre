//
//  File.swift
//  
//
//  Created by Kim Dongjoo on 5/29/24.
//

import Common

protocol LoginUseCaseProtocol {
    func kakaoLogin() -> Observable<Bool>
}

final class LoginUseCase: LoginUseCaseProtocol {
    private let loginService: LoginServiceType
    
    init(loginService: LoginServiceType) {
        self.loginService = loginService
    }
    
    func kakaoLogin() -> Observable<Bool> {
        return loginService.requestKakaoLogin()
    }
}
