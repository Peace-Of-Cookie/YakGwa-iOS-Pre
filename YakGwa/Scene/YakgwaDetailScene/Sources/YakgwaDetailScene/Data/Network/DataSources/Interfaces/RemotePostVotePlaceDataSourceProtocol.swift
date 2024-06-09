//
//  RemotePostVotePlaceDataSourceProtocol.swift
//
//
//  Created by Ekko on 6/7/24.
//

import RxSwift

public protocol RemotePostVotePlaceDataSourceProtocol {
    func postVotePlace(userId: Int, meetId: Int,requestDTO: PostVotePlacesRequestDTO) -> Single<PostVotePlacesResponseDTO>
}

