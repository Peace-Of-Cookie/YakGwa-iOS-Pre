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
    
    public typealias placeId = Int
    
    public enum Action {
        case viewWillAppeared
        case placeSelected(Int)
    }
    
    public enum Mutation {
        case setPlaces([MeetVoteInfo.RecommendPlace])
        case setSelectedPlaces([placeId])
    }
    
    public struct State {
        var meetId: Int
        var places: [MeetVoteInfo.RecommendPlace]?
        var selectedPlaces: [placeId] = []
    }
    
    public var initialState: State
    
    public init(
        meetId: Int = 40,
        fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCaseProtocol
    ) {
        self.initialState = State(meetId: meetId, selectedPlaces: [])
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
            
        case .placeSelected(let placeId):
            var selectedPlaces = currentState.selectedPlaces
            if selectedPlaces.contains(placeId) {
                selectedPlaces.removeAll() { $0 == placeId }
            } else {
                selectedPlaces.append(placeId)
            }
            return .just(Mutation.setSelectedPlaces(selectedPlaces))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setPlaces(let places):
            newState.places = places
        case .setSelectedPlaces(let selectedPlaces):
            newState.selectedPlaces = selectedPlaces
        }
        
        return newState
    }
}
