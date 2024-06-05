//
//  MakeYakgwaReactor.swift
//
//
//  Created by Ekko on 6/3/24.
//

import Foundation

import Util

import ReactorKit

public final class MakeYakgwaReactor: Reactor {
    // MARK: - Properties
    let fetchThemeUseCase: FetchMeetThemesUseCaseProtocol
    let createMeetUseCase: CreateMeetUseCaseProtocol
    
    let disposeBag: DisposeBag = DisposeBag()
    
    public enum Action {
        case viewWillAppeared
        
        case updateTitle(String)
        case updateDescription(String)
        
        /// 테마 선택 시 IndexPath 반환
        case updateTheme(Int)
        case updateLocation(String)
        case updateStartDate(Date)
        case updateEndDate(Date)
        case updateStartTime(Date)
        case updateEndTime(Date)
        case updateExpiredDate(Int)
        
        case alreadySelectedLocationChecked
        case startDateButtonTapped
        case endDateButtonTapped
        case startTimeButtonTapped
        case endTimeButtonTapped
        case alreadySelectedDateChecked
        case changeExpireDateTapped
        
        case confirmButtonTapped
    }
    
    public enum Mutation {
        case setThemes([MeetTheme])
        
        case setTitle(String)
        case setDescription(String)
        case setTheme(Int)
        case setLocation(String)
        case setStartDate(Date)
        case setEndDate(Date)
        case setStartTime(Date)
        case setEndTime(Date)
        case setExpiredDate(Int)
        
        case showStartDatePicker
        case showEndDatePicker
        case showStartTimePicker
        case showEndTimePicker
        
        case showExpireHourPicker
        
        case createNewMeet
    }
    
    public struct State {
        
        @Pulse var isDateViewShow: PickerSheetType?
        @Pulse var isExpireHourViewSHow: Bool = false
        
        var themes: [MeetTheme] = []
        
        /// 약속 타이틀
        var yakgwaTitle: String?
        /// 약속 설명
        var yakgwaDescription: String?
        /// 약속 테마 (선택된 Index)
        var yakgwaTheme: Int?
        /// 이미 장소가 결졍된 여부
        var alreadySelectedLocation: Bool = false
        /// 약속 장소
        var yakgwaLocation: [String] = ["홍대", "역삼역"]
        /// 이미 시간이 정해진 여부
        var alreadySelectedDate: Bool = false
        /// 약속 시작 날짜
        var yakgwaStartDate: Date?
        /// 약속 종료 날짜
        var yakgwaEndDate: Date?
        /// 약속 시작 시간
        var yakgwaStartTime: Date?
        /// 약속 종료 시간
        var yakgwaEndTime: Date?
        /// 초대 마감 시간
        var expiredDate: Int?
        
        /// 약속 생성 완료
        var makeMeetComplete: Bool = false
    }
    
    public var initialState: State
    
    init (
        fetchThemeUseCase: FetchMeetThemesUseCaseProtocol,
        createMeetUseCase: CreateMeetUseCaseProtocol
    ) {
        self.fetchThemeUseCase = fetchThemeUseCase
        self.createMeetUseCase = createMeetUseCase
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppeared:
            guard let token = AccessTokenManager.readAccessToken() else { return .empty() }// TODO: - Error 처리
            return fetchThemeUseCase.execute(token: token)
                .asObservable()
                .map { Mutation.setThemes($0)}
                .catchAndReturn(Mutation.setThemes([]))
        case .confirmButtonTapped:
//            guard let token = AccessTokenManager.readAccessToken() else { return .empty() }
//            return createMeetUseCase.execute(token: token, 
//                                             userId: 4,
//                                             data: MakeMeetRequestDTO(from: Yakgwa()))
//                .asObservable()
//                .map { _ in Mutation.createNewMeet }
            let entity = Yakgwa(
                            yakgwaTitle: currentState.yakgwaTitle,
                            yakgwaDescription: currentState.yakgwaDescription,
                            yakgwaTheme: currentState.yakgwaTheme,
                            alreadySelectedLocation: currentState.alreadySelectedLocation,
                            yakgwaLocation: currentState.yakgwaLocation,
                            alreadySelectedDate: currentState.alreadySelectedDate,
                            yakgwaStartDate: currentState.yakgwaStartDate,
                            yakgwaEndDate: currentState.yakgwaEndDate,
                            yakgwaStartTime: currentState.yakgwaStartTime,
                            yakgwaEndTime: currentState.yakgwaEndTime,
                            expiredDate: currentState.expiredDate
                        )
            
            guard let token = AccessTokenManager.readAccessToken() else { return .empty() }
            guard let userId = KeyChainManager.read(key: "userId") else { return .empty() }
            return createMeetUseCase.execute(token: token, userId: Int(userId) ?? 0, data: MakeMeetRequestDTO(from: entity))
                .asObservable()
                .map { _ in Mutation.createNewMeet }
            
        case .updateTitle(let title):
            return .just(.setTitle(title))
        case .updateDescription(let description):
            return .just(.setDescription(description))
        case .updateTheme(let theme):
            return .just(.setTheme(theme))
        case .updateLocation(let location):
            return .just(.setLocation(location))
        case .updateStartDate(let startDate):
            return .just(.setStartDate(startDate))
        case .updateEndDate(let endDate):
            return .just(.setEndDate(endDate))
        case .updateStartTime(let startTime):
            return .just(.setStartTime(startTime))
        case .updateEndTime(let endTime):
            return .just(.setEndTime(endTime))
        case .updateExpiredDate(let expiredDate):
            return .just(.setExpiredDate(expiredDate))
            
        case .startDateButtonTapped:
            return .just(.showStartDatePicker)
        case .endDateButtonTapped:
            return .just(.showEndDatePicker)
        case .startTimeButtonTapped:
            return .just(.showStartTimePicker)
        case .endTimeButtonTapped:
            return .just(.showEndTimePicker)
            
        case .changeExpireDateTapped:
            return .just(.showExpireHourPicker)
            
        default:
            return .empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setThemes(let themes):
            newState.themes = themes
            
        case .setTitle(let title):
            newState.yakgwaTitle = title
        case .setDescription(let description):
            newState.yakgwaDescription = description
        case .setTheme(let theme):
            newState.yakgwaTheme = theme
        
        case .setStartDate(let date):
            newState.yakgwaStartDate = date
        case .setEndDate(let date):
            newState.yakgwaEndDate = date
        case .setStartTime(let time):
            newState.yakgwaStartTime = time
        case .setEndTime(let time):
            newState.yakgwaEndTime = time
        
        case .setExpiredDate(let hour):
            newState.expiredDate = hour
            
        case .showStartDatePicker:
            newState.isDateViewShow = .startDate
        case .showEndDatePicker:
            newState.isDateViewShow = .endDate
        case .showStartTimePicker:
            newState.isDateViewShow = .startTime
        case .showEndTimePicker:
            newState.isDateViewShow = .endTime
            
        case .showExpireHourPicker:
            newState.isExpireHourViewSHow = true
            
        case .createNewMeet:
            print("컴플리트")
            newState.makeMeetComplete = true
        default:
            break
        }
        
        return newState
    }
}

enum PickerSheetType {
    case startDate
    case endDate
    case startTime
    case endTime
}
