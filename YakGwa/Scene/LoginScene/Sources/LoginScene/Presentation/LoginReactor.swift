//
//  File.swift
//  
//
//  Created by Kim Dongjoo on 5/29/24.
//

import Common

import ReactorKit

public final class LoginReactor: Reactor {
    public enum Action {
        case kakaoLogin
    }
    
    public enum Mutation {
        case setLoggedIn(Bool)
    }
    
    public struct State {
        var isLoggedIn: Bool = false
    }
    
    public let initialState = State()
    
    private let loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .kakaoLogin:
            return loginUseCase.kakaoLogin()
                .map { Mutation.setLoggedIn($0) }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoggedIn(isLoggedIn):
            newState.isLoggedIn = isLoggedIn
        }
        return newState
    }
}

extension LoginReactor {
    private func requestKakaoLogin() {
        
    }
}
