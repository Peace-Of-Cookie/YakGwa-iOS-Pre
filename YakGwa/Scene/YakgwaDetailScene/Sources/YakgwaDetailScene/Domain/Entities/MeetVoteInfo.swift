//
//  File.swift
//  
//
//  Created by Ekko on 6/6/24.
//

import Foundation

public struct MeetVoteInfo: Equatable {
    public let recommendPlaces: [RecommendPlace]?
    
    public let startDate: String?
    public let endDate: String?
    public let startTime: String?
    public let endTime: String?
    
    public struct RecommendPlace: Equatable {
        public let placeId: Int?
        public let name: String?
        public let address: String?
        public let description: String?
    }
}
