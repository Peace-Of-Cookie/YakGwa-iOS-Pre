//
//  FetchThemeRepository.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Network
import RxSwift

final class FetchThemeRepository: FetchThemeRepositoryProtocol {
    
    private let remoteDataSource: RemoteFetchThemeDataSourceProtocol
    
    init(remoteDataSource: RemoteFetchThemeDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchMeetThemes(token: String) -> Single<[MeetTheme]> {
        remoteDataSource.fetchMeetThemes(token: token)
            .map { $0.toDomain() }
    }
}
