//
//  RemotePostVotePlaceDataSource.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import Network
import RxSwift

public final class RemotePostVotePlaceDataSource: BaseRemoteDataSource<YakgwaDetailAPI>, RemotePostVotePlaceDataSourceProtocol {
    public func postVotePlace(userId: Int, meetId: Int, requestDTO: PostVotePlacesRequestDTO) -> Single<PostVotePlacesResponseDTO> {
        do {
            let jsonData = try JSONEncoder().encode(requestDTO)
            return request(
                .postPlaceVote(userId: userId, meetId: meetId, places: jsonData)
            ).map(PostVotePlacesResponseDTO.self)
        } catch {
            return .error(error)
        }
    }
}
