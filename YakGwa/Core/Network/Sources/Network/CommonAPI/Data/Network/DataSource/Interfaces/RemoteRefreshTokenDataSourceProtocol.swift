//
//  RemoteRefreshTokenDataSourceProtocol.swift
//
//
//  Created by Kim Dongjoo on 7/2/24.
//

import RxSwift

public protocol RemoteRefreshTokenDataSourceProtocol {
    func refreshToken(refreshToken: String) -> Single<ReissueResponseDTO>
}
