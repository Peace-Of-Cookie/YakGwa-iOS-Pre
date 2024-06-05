//
//  RemoteFetchDataSourceProtocol.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Foundation

import Network

import RxSwift

protocol RemoteFetchThemeDataSourceProtocol {
    func fetchMeetThemes(token: String) -> Single<MeetThemesResponseDTO>
}
