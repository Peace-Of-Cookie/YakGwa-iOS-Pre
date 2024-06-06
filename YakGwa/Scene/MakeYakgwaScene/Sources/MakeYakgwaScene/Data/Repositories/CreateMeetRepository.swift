//
//  CreateMeetRepository.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Network
import RxSwift

final class CreateMeetRepository: CreateMeetRepositoryProtocol {
    
    private let remoteDataSource: RemoteCreateMeetDataSourceProtocol
    
    init(remoteDataSource: RemoteCreateMeetDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func createMeet(token: String, userId: Int, data: MakeMeetRequestDTO) -> Single<Int> {
        return remoteDataSource.createMeet(token: token, userId: userId, data: data)
            .map { result in
                return result.result.meetId
            }
    }
}
