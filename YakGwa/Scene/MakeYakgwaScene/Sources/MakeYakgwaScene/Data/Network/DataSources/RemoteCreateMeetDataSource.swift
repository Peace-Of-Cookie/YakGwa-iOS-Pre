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
            do {
                let jsonData = try JSONEncoder().encode(data)
                return request(
                    .createMeet(token: token, userId: userId, body: jsonData)
                ).map(MakeMeetResponseDTO.self)
            } catch {
                return .error(error)
            }
        }
}
