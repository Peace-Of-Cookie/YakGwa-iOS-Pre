//
//  UserVoteStatusReactor.swift
//
//
//  Created by Ekko on 6/7/24.
//

import ReactorKit
import Util

public final class UserVoteStatusReactor: Reactor {
    let fetchUserVoteStatusUseCase: FetchUserVoteStatusUseCaseProtocol
    
    public enum Action {
        
    }
    
    public enum Mutation {
        
    }
    
    public struct State {
        var meetId: Int
    }
    
    public var initialState: State
    
    public init(
        meetId: Int,
        fetchUserVoteStatusUseCase: FetchUserVoteStatusUseCaseProtocol
    ) {
        self.initialState = State(meetId: meetId)
        self.fetchUserVoteStatusUseCase = fetchUserVoteStatusUseCase
    }
    
    
}
