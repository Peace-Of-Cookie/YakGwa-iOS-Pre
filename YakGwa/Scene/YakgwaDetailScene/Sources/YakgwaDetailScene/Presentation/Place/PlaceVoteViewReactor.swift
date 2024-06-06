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
        
    }
    
    public enum Mutation {
        
    }
    
    public struct State {
        
    }
    
    public var initialState: State = State()
    
    init(
        meetId: Int,
        fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCaseProtocol
    ) {
        self.fetchMeetVoteInfoUseCase = fetchMeetVoteInfoUseCase
    }
}
