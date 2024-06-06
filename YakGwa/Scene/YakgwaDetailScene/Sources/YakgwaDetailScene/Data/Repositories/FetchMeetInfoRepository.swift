//
//  File.swift
//  
//
//  Created by Ekko on 6/6/24.
//

import Network
import RxSwift

public final class FetchMeetInfoRepository: FetchMeetInfoRepositoryProtocol {
    private let remoteDataSource: RemoteFetchMeetInfoDataSourceProtocol
    
    init(remoteDataSource: RemoteFetchMeetInfoDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchMeetInfo(token: String, userId: Int, meetId: Int) -> Single<MeetInfoResponseDTO> {
        remoteDataSource.fetchMeetInfo(token: token, userId: userId, meetId: meetId)
    }
}
