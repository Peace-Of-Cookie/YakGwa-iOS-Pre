//
//  PostVotePlaceRepository.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation
import RxSwift

public final class PostVotePlaceRepositoy: PostVotePlaceRepositoryProtocol {
    
    private let remoteDataSource: RemotePostVotePlaceDataSourceProtocol
    
    public init(remoteDataSource: RemotePostVotePlaceDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func postVotePlace(userId: Int, meetId: Int, requestDTO: PostVotePlacesRequestDTO) -> Single<PostVotePlacesResponseDTO> {
        return remoteDataSource.postVotePlace(userId: userId, meetId: meetId, requestDTO: requestDTO)
    }
}
