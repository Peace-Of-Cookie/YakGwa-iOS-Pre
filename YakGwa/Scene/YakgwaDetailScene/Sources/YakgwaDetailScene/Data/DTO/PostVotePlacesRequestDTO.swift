//
//  PostVotePlacesRequestDTO.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

/*
 {
   "candidatePlaceIds": [
     0
   ]
 }
 */
public struct PostVotePlacesRequestDTO: Codable, Equatable {
    public let candidatePlaceIds: [Int]
}



