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
    let postVoteScheduleUseCase: PostVoteScheduleUseCaseProtocol
    let disposeBag: DisposeBag = DisposeBag()
    
    public enum Action {
        case viewWillAppeared
        case dateSelected(Date)
        case timeSelected(String)
        case nextButtonTapped
    }
    
    public enum Mutation {
        case selectedDate(Date)
        case setDateRange(startDate: Date, endDate: Date)
        case setTimeRange(startTime: Date, endTime: Date)
        case setLoading(Bool)
        case setSelectedTimes(Date, [String])
        case navigateToLocationVoteScene(Int) // 모임 id 포함
        case postVoteSchedule(PostVoteSchedulesResponseDTO)
    }
    
    public struct State {
        var isLoading: Bool? = false
        var meetId: Int
        var fetchedDate: (startDate: Date, endDate: Date)?
        var fetchedTime: (startTime: Date, endTime: Date)?
        var showDateTimePicker: Date? = nil
        var selectedTimes: [Date: [String]] = [:]
        var postVoteSchedulesResult: PostVoteSchedulesResponseDTO?
        
        @Pulse var shouldNavigateToVoteScene: Int = 0
        
    }
    
    public var initialState: State
    
    public init(
        meetId: Int = 23, // TODO: - Test 40
        fetchMeetVoteInfoUseCase: FetchMeetVoteInfoUseCaseProtocol,
        postVoteScheduleUseCase: PostVoteScheduleUseCaseProtocol
    ) {
        self.initialState = State(meetId: meetId)
        self.fetchMeetVoteInfoUseCase = fetchMeetVoteInfoUseCase
        self.postVoteScheduleUseCase = postVoteScheduleUseCase
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
        case .timeSelected(let selectedTime):
            guard let selectedDate = currentState.showDateTimePicker else { return .empty() }
            var times = currentState.selectedTimes[selectedDate] ?? []
            
            if let index = times.firstIndex(of: selectedTime) {
                times.remove(at: index)
            } else {
                times.append(selectedTime)
            }
            
            return .just(.setSelectedTimes(selectedDate, times))
        case .nextButtonTapped:
            guard let userId = KeyChainManager.read(key: "userId") else { return .empty() }
            // let userId: Int = 4 // TODO: - User Id 테스트를 위한 임시 값 입니다.
            return Observable.concat([
                postVoteScheduleUseCase
                    .execute(
                        userId: Int(userId) ?? 0,
                        meetId: currentState.meetId,
                        requestDTO: PostVoteSchedulesRequestDTO(selectedTimes: currentState.selectedTimes))
                    .asObservable()
                    .map { Mutation.postVoteSchedule($0) }
                    .catch { error in
                        print("Error occured: \(error)")
                        return Observable.empty()
                    },
                Observable.just(.navigateToLocationVoteScene(currentState.meetId))
            ])
            // return .just(.navigateToLocationVoteScene(currentState.meetId))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .selectedDate(let date):
            // let calendar  = Calendar.current
            // guard let selectedDate = calendar.date(byAdding: .day, value: 1, to: date) else { return newState }
            newState.showDateTimePicker = date
        case .setDateRange(let startDate, let endDate):
            newState.fetchedDate = (startDate: startDate, endDate: endDate)
        case .setTimeRange(let startTime, let endTime):
            newState.fetchedTime = (startTime: startTime, endTime: endTime)
        case .setSelectedTimes(let date, let times):
            newState.selectedTimes[date] = times
        case .navigateToLocationVoteScene(let meetId):
            newState.shouldNavigateToVoteScene = meetId
        case .postVoteSchedule(let postVoteSchedulesResponseDTO):
            newState.postVoteSchedulesResult = postVoteSchedulesResponseDTO
        }
        return newState
    }
}
