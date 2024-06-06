//
//  YakgwaDetailReactor.swift
//
//
//  Created by Ekko on 6/6/24.
//

import ReactorKit

public final class YakgwaDetailReactor: Reactor {
    // MARK: - Properties
    
    public enum Action {
        case viewWillAppeared
    }
    
    public enum Mutation {
        case setInfo(MeetInfo)
    }
    
    public struct State {
        var meetId: Int
        var meetInfo: MeetInfo?
    }
    
    public var initialState: State
    
    init(meetId: Int) {
        self.initialState = State(meetId: meetId)
    }
    
//    public func mutate(action: Action) -> Observable<Mutation> {
//        switch action {
//        case .viewWillAppeared:
//            return .just(.setInfo(MeetInfo(id: 1, name: "Meet")))
//        }
//    }
    
}
