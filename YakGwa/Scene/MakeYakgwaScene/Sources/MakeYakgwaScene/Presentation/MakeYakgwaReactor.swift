//
//  MakeYakgwaReactor.swift
//
//
//  Created by Ekko on 6/3/24.
//

import ReactorKit

public final class MakeYakgwaReactor: Reactor {
    public enum Action {
    }
    
    public enum Mutation {
    }
    
    public struct State {
    }
    
    public var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
