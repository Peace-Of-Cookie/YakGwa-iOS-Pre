//
//  FetchMeetInfoUseCase.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Network
import RxSwift

public protocol FetchMeetInfoUseCaseProtocol {
    func execute(token: String, userId: Int, meetId: Int) -> Single<MeetInfoResponseDTO>
}

public final class FetchMeetInfoUseCase: FetchMeetInfoUseCaseProtocol {
    private let repository: FetchMeetInfoRepositoryProtocol
    
    init(repository: FetchMeetInfoRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(token: String, userId: Int, meetId: Int) -> Single<MeetInfoResponseDTO> {
        repository.fetchMeetInfo(token: token, userId: userId, meetId: meetId)
    }
}
