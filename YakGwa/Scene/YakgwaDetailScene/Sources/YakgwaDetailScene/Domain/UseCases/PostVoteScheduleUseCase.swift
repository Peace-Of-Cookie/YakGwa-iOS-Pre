//
//  PostVoteScheduleUseCase.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Network
import RxSwift

public protocol PostVoteScheduleUseCaseProtocol {
    func execute(userId: Int, meetId: Int, requestDTO: PostVoteSchedulesRequestDTO) -> Single<PostVoteSchedulesResponseDTO>
}

public final class PostVoteScheduleUseCase: PostVoteScheduleUseCaseProtocol {
    private let repository: PostVoteScheduleRepositoryProtocol
    
    public init(repository: PostVoteScheduleRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(userId: Int, meetId: Int, requestDTO: PostVoteSchedulesRequestDTO) -> Single<PostVoteSchedulesResponseDTO> {
        return repository.postVoteSchedule(userId: userId, meetId: meetId, requestDTO: requestDTO)
    }
}
