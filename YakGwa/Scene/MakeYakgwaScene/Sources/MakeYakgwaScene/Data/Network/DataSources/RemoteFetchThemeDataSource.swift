//
//  File.swift
//  
//
//  Created by Ekko on 6/5/24.
//

import Foundation

import Network
import RxSwift

final class RemoteFetchThemeDataSource: BaseRemoteDataSource<MakeYakgwaAPI>, RemoteFetchThemeDataSourceProtocol {
    func fetchMeetThemes(token: String) -> Single<MeetThemesResponseDTO> {
        request(
            .fetchMeetThemes(token: token)
        ).map(MeetThemesResponseDTO.self)
    }
}
