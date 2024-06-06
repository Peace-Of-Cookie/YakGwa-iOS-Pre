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
        case selectedDate(Date)
        case setDateRange(startDate: Date, endDate: Date)
        case setTimeRange(startTime: Date, endTime: Date)
        case setLoading(Bool)
    }
    
    public struct State {
        var isLoading: Bool? = false
        var meetId: Int
        var fetchedDate: (startDate: Date, endDate: Date)?
        var fetchedTime: (startTime: Date, endTime: Date)?
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
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                fetchMeetVoteInfoUseCase
                    .execute(meetId: currentState.meetId)
                    .asObservable()
                    .flatMap { meetVoteInfo -> Observable<Mutation> in
                        let startDate = meetVoteInfo.startDate?.toDate(format: "yyyy-MM-dd") ?? Date()
                        let endDate = meetVoteInfo.endDate?.toDate(format: "yyyy-MM-dd") ?? Date()
                        let startTime = meetVoteInfo.startTime?.toDate(format: "HH:mm") ?? Date()
                        let endTime = meetVoteInfo.endTime?.toDate(format: "HH:mm") ?? Date()
                        return Observable.from([
                            .setDateRange(startDate: startDate, endDate: endDate),
                            .setTimeRange(startTime: startTime, endTime: endTime)
                        ])
                    },
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .dateSelected(let date):
            return .just(.selectedDate(date))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .selectedDate(let date):
            newState.showDateTimePicker = date
        case .setDateRange(let startDate, let endDate):
            newState.fetchedDate = (startDate: startDate, endDate: endDate)
        case .setTimeRange(let startTime, let endTime):
            newState.fetchedTime = (startTime: startTime, endTime: endTime)
        }
        return newState
    }
}
