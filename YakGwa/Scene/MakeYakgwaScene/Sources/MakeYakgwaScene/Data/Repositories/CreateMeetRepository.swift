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
    
    func createMeet(token: String, userId: Int, data: MakeMeetRequestDTO) -> Single<Bool> {
        remoteDataSource.createMeet(token: token, userId: userId, data: data)
            .map { result in
                print("생성 결과: \(result)")
                if result.status == 200 {
                    return true
                } else {
                    return false
                }
            }
    }
}
