//
//  MakeYakgwaReactor.swift
//
//
//  Created by Ekko on 6/3/24.
//

import Foundation

import ReactorKit

public final class MakeYakgwaReactor: Reactor {
    public enum Action {
        case confirmButtonTapped
    }
    
    public enum Mutation {
        // case setYakgwaInfo()
    }
    
    public struct State {
        /// 약속 타이틀
        var yakgwaTitle: String?
        /// 약속 설명
        var yakgwaDescription: String?
        /// 약속 테마
        var yakgwaTheme: String?
        /// 이미 장소가 결졍된 여부
        var alreadySelectedLocation: Bool = false
        /// 약속 장소
        var yakgwaLocation: [String] = []
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
        var expiredDate: Date?
        
    }
    
    public var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
