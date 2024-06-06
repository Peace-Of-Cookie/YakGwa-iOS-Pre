//
//  RemoteFetchMeetVoteDataSource.swift
//
//
//  Created by Ekko on 6/6/24.
//

import Foundation

import Network
import RxSwift

//public final class RemoteFetchMeetVoteDataSource: BaseRemoteDataSource<YakgwaDetailAPI>, RemoteFetchMeetVoteDataSourceProtocol  {
//    public func fetchMeetVoteInfo(meetId: Int) -> Single<MeetVoteResponseDTO> {
//        print("fetchMeetVoteInfo: \(meetId)")
//        return request(
//            .fetchMeetVoteInfo(meetId: meetId)
//        ).map(MeetVoteResponseDTO.self)
//    }
//    
//    // TODO: - Will Be Deprecated
//    public init() { }
//}

public final class RemoteFetchMeetVoteDataSource: BaseRemoteDataSource<YakgwaDetailAPI>, RemoteFetchMeetVoteDataSourceProtocol  {
    public func fetchMeetVoteInfo(meetId: Int) -> Single<MeetVoteResponseDTO> {
        print("fetchMeetVoteInfo: \(meetId)")
        
        return request(.fetchMeetVoteInfo(meetId: meetId))
            .do(onSuccess: { response in
                print("fetchMeetVoteInfo 성공: \(response)")
            }, onError: { error in
                print("fetchMeetVoteInfo 실패: \(error.localizedDescription)")
            })
            .map(MeetVoteResponseDTO.self)
            .catch { error in
                // 오류를 처리하고 원하는 동작을 추가할 수 있습니다.
                print("fetchMeetVoteInfo 중 오류 발생: \(error.localizedDescription)")
                return Single.error(error)
            }
    }
    
    // TODO: - Will Be Deprecated
    public init() { }
}
