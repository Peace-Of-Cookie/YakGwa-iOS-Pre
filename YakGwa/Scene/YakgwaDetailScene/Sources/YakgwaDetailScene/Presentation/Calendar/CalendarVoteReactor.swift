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
    let fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCaseProtocol
    
    let disposeBag: DisposeBag = DisposeBag()
    
    public enum Action {
        case viewWillAppeared
        case dateSelected(Date)
    }
    
    public enum Mutation {
        case setInfo(MeetVoteInfo)
        case selectedDate(Date)
    }
    
    public struct State {
        var meetId: Int
        var meetVoteInfo: MeetVoteInfo?
        var startDate: Date?
        var endDate: Date?
        var startTime: Date?
        var endTime: Date?
        var showDateTimePicker: Date? = nil
    }
    
    public var initialState: State
    
    public init(
        meetId: Int = 23, // TODO: - Test 40
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
                .asObservable()
                .map { .setInfo($0) }
            
        case .dateSelected(let date):
            return .just(.selectedDate(date))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setInfo(let info):
            newState.meetVoteInfo = info
            newState.startDate = info.startDate?.toDate(format: "yyyy-MM-dd")
            newState.endDate = info.endDate?.toDate(format: "yyyy-MM-dd")
            newState.startTime = info.startTime?.toDate(format: "HH:mm")
            newState.endTime = info.startTime?.toDate(format: "HH:mm")
        case .selectedDate(let date):
            newState.showDateTimePicker = date
        }
        return newState
    }
}
