//
//  RefreshTokenDataSource.swift
//  
//
//  Created by Kim Dongjoo on 7/2/24.
//

import RxSwift

public final class RefreshTokenDataSource: BaseRemoteDataSource<YakgwaCommonAPI>, RemoteRefreshTokenDataSourceProtocol {
    public func refreshToken(refreshToken: String) -> Single<ReissueResponseDTO> {
        request(
            .reissue(refreshToken: refreshToken)
        ).map(ReissueResponseDTO.self)
    }
}
