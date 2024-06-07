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
    let postVotePlaceUseCase: PostVotePlaceUseCaseProtocol
    let disposeBag: DisposeBag = DisposeBag()
    
    public typealias placeId = Int
    
    public enum Action {
        case viewWillAppeared
        case placeSelected(Int)
        case completeButtonTapped
    }
    
    public enum Mutation {
        case setPlaces([MeetVoteInfo.RecommendPlace])
        case setSelectedPlaces([placeId])
        case postVotePlace(PostVotePlacesResponseDTO)
        case navigateToAfterSelectionScene(Int) // 화면 이동 모임 id 포함
    }
    
    public struct State {
        var meetId: Int
        var places: [MeetVoteInfo.RecommendPlace]?
        var selectedPlaces: [placeId] = []
        var postVotePlacesResult: PostVotePlacesResponseDTO?
        
        @Pulse var shouldNavigateToAfterSelectionScene: Int = 0
    }
    
    public var initialState: State
    
    public init(
        meetId: Int,
        fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCaseProtocol,
        postVotePlaceUseCase: PostVotePlaceUseCaseProtocol
    ) {
        self.initialState = State(
            meetId: meetId,
            selectedPlaces: []
        )
        self.fetchMeetVoteInfoUseCase = fetchMeetVoteInfoUseCase
        self.postVotePlaceUseCase = postVotePlaceUseCase
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
            
        case .completeButtonTapped:
            guard let userId = KeyChainManager.read(key: "userId") else { return .empty() }
            return Observable.concat([
                postVotePlaceUseCase
                    .execute(
                        userId: Int(userId) ?? 0,
                        meetId: currentState.meetId,
                        requestDTO: PostVotePlacesRequestDTO(selectedPlaces: currentState.selectedPlaces))
                    .asObservable()
                    .map { Mutation.postVotePlace($0) }
                    .catch { error in
                        return Observable.empty()
                    },
                // Observable 화면 이동 로직 추가
                Observable.just(.navigateToAfterSelectionScene(currentState.meetId))
            ])
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setPlaces(let places):
            newState.places = places
        case .setSelectedPlaces(let selectedPlaces):
            newState.selectedPlaces = selectedPlaces
        case .navigateToAfterSelectionScene(let meetId):
            newState.shouldNavigateToAfterSelectionScene = meetId
        case .postVotePlace(let responseDTO):
            newState.postVotePlacesResult = responseDTO
        }
        
        return newState
    }
}
