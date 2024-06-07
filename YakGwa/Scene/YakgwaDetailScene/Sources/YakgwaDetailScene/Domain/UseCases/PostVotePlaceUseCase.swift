//
//  PostVotePlaceUseCase.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Network
import RxSwift

public protocol PostVotePlaceUseCaseProtocol {
    func execute(userId: Int, meetId: Int, requestDTO: PostVotePlacesRequestDTO) -> Single<PostVotePlacesResponseDTO>
}

public final class PostVotePlaceUseCase: PostVotePlaceUseCaseProtocol {
    private let repository: PostVotePlaceRepositoryProtocol
    
    public init(repository: PostVotePlaceRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(userId: Int, meetId: Int, requestDTO: PostVotePlacesRequestDTO) -> Single<PostVotePlacesResponseDTO> {
        return repository.postVotePlace(userId: userId, meetId: meetId, requestDTO: requestDTO)
    }
}
