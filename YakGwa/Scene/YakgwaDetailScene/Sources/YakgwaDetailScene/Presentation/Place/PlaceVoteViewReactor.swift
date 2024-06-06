//
//  PlaceVoteViewReactor.swift
//
//
//  Created by Ekko on 6/7/24.
//

import ReactorKit
import Util
import Network

public final class PlaceVoteViewReactor: Reactor {
    let fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCaseProtocol
    let disposeBag: DisposeBag = DisposeBag()
    
    public enum Action {
        case viewWillAppeared
    }
    
    public enum Mutation {
        case setPlaces([MeetVoteInfo.RecommendPlace])
    }
    
    public struct State {
        var meetId: Int
        var places: [MeetVoteInfo.RecommendPlace]?
    }
    
    public var initialState: State
    
    public init(
        meetId: Int = 40,
        fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCaseProtocol
    ) {
        self.initialState = State(meetId: meetId)
        self.fetchMeetVoteInfoUseCase = fetchMeetVoteInfoUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppeared:
            return fetchMeetVoteInfoUseCase
                .execute(meetId: currentState.meetId)
                .map { result in
                    result.recommendPlaces ?? []
                }.asObservable()
                .map { Mutation.setPlaces($0)}
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setPlaces(let places):
            newState.places = places
        }
        
        return newState
    }
}
