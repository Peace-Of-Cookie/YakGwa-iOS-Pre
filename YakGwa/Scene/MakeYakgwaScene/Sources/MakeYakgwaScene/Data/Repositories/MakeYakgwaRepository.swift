//
//  MakeYakgwaRepository.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Network
import RxSwift

final class MakeYakgwaRepository: MakeYakgwaRepositoryProtocol {
    
    private let remoteDataSource: RemoteFetchThemeDataSourceProtocol
    
    init(remoteDataSource: RemoteFetchThemeDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchMeetThemes(token: String) -> Single<[MeetTheme]> {
        remoteDataSource.fetchMeetThemes(token: token)
            .map { $0.toDomain() }
    }
}
