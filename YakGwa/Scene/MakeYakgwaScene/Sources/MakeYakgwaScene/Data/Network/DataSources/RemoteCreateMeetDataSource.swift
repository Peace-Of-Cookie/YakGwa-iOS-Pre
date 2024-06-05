//
//  File.swift
//  
//
//  Created by Ekko on 6/5/24.
//

import Foundation

import Network
import RxSwift

final class RemoteCreateMeetDataSource: BaseRemoteDataSource<MakeYakgwaAPI>, RemoteCreateMeetDataSourceProtocol {
    func createMeet(token: String, userId: Int, data: MakeMeetRequestDTO) -> Single<MakeMeetResponseDTO> {
        request(
            .createMeet(token: token, userId: userId, body: data)
        ).map(MakeMeetResponseDTO.self)
    }
}
