//
//  File.swift
//  
//
//  Created by Ekko on 6/5/24.
//

import Foundation

import Network

import RxSwift

protocol RemoteCreateMeetDataSourceProtocol {
    func createMeet(token: String, userId: Int, data: MakeMeetRequestDTO) -> Single<MakeMeetResponseDTO>
}
