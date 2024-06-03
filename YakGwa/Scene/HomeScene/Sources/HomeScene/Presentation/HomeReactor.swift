//
//  HomeReactor.swift
//  
//
//  Created by Kim Dongjoo on 6/3/24.
//

import ReactorKit

public final class HomeReactor: Reactor {
    public enum Action {
        /// 약속 만들기
        case moveToMakeAppointment
    }
    
    public enum Mutation {
        case navigateToMakeAppointment
    }
    
    public struct State {
        var shouldNavigateToMakeAppointment: Bool = false
    }
    
    public var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .moveToMakeAppointment:
            return Observable.just(.navigateToMakeAppointment)
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .navigateToMakeAppointment:
            newState.shouldNavigateToMakeAppointment = true
        }
        
        return newState
    }
}
