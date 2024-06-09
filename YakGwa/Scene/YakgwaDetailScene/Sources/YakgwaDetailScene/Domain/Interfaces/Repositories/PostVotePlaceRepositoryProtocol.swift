//
//  PostVotePlaceRepositoryProtocol.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import RxSwift
import Network

public protocol PostVotePlaceRepositoryProtocol {
    func postVotePlace(userId: Int, meetId: Int, requestDTO: PostVotePlacesRequestDTO) -> Single<PostVotePlacesResponseDTO>
}
