//
//  FetchMeetThemesUseCase.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Network
import RxSwift

public protocol FetchMeetThemesUseCaseProtocol {
    func execute(token: String) -> Single<[MeetTheme]>
}

public final class FetchMeetThemesUseCase: FetchMeetThemesUseCaseProtocol {
    private let repository: MakeYakgwaRepositoryProtocol
    
    public init(repository: MakeYakgwaRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(token: String) -> Single<[MeetTheme]> {
        repository.fetchMeetThemes(token: token)
    }
}
