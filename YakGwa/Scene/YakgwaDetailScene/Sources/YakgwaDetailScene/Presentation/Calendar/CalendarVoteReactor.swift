//
//  CalendarVoteReactor.swift
//  
//
//  Created by Ekko on 6/6/24.
//

import Foundation

import ReactorKit
import Util
import Network

public final class CalendarVoteReactor: Reactor {
    // MARK: - Properties
    
    public enum Action {
        // case setStartDate(Date)
        case dateSelected(Date)
    }
    
    public enum Mutation {
        case selectedDate(Date)
    }
    
    public struct State {
        var showDateTimePicker: Date? = nil
    }
    
    public var initialState: State = State()
    
    public init() { 
        
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .dateSelected(let date):
            return .just(.selectedDate(date))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .selectedDate(let date):
            newState.showDateTimePicker = date
        }
        return newState
    }
}
