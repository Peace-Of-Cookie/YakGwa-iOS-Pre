//
//  FetchThemeRepositoryProtocol.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Network
import RxSwift

public protocol FetchThemeRepositoryProtocol {
    func fetchMeetThemes(token: String) -> Single<[MeetTheme]>
}
