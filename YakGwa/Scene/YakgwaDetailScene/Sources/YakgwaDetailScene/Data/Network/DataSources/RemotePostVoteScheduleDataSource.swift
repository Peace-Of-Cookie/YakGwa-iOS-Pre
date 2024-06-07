//
//  RemotePostVoteScheduleDataSource.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation

import Network
import RxSwift

public final class RemotePostVoteScheduleDataSource: BaseRemoteDataSource <YakgwaDetailAPI>, RemotePostVoteScheduleDataSourceProtocol {
    public func postVoteSchedule(userId: Int, meetId: Int, requestDTO: PostVoteSchedulesRequestDTO) -> Single<PostVoteSchedulesResponseDTO> {
        do {
            let jsonData = try JSONEncoder().encode(requestDTO)
            return request(
                .postScheduleVote(userId: userId, meetId: meetId, times: jsonData)
            ).map(PostVoteSchedulesResponseDTO.self)
        } catch {
            return .error(error)
        }
    }
}
//public final class RemotePostVoteScheduleDataSource: BaseRemoteDataSource<YakgwaDetailAPI>, RemotePostVoteScheduleDataSourceProtocol {
//    public func postVoteSchedule(userId: Int, meetId: Int, requestDTO: PostVoteSchedulesRequestDTO) -> Single<PostVoteSchedulesResponseDTO> {
//        do {
//            print("빵애애요: \(meetId)")
//            let jsonData = try JSONEncoder().encode(requestDTO)
//            print("JSON Data: \(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")")
//
//            // 디코딩을 통해 JSON 데이터가 올바른지 확인
//            do {
//                let decodedDTO = try JSONDecoder().decode(PostVoteSchedulesRequestDTO.self, from: jsonData)
//                print("Decoded DTO: \(decodedDTO)")
//            } catch let decodeError {
//                print("Decoding Error: \(decodeError)")
//            }
//
//            return request(
//                .postScheduleVote(userId: userId, meetId: meetId, times: jsonData)
//            ).map(PostVoteSchedulesResponseDTO.self)
//        } catch let encodeError {
//            print("Encoding Error: \(encodeError)")
//            return .error(encodeError)
//        }
//    }
//}
