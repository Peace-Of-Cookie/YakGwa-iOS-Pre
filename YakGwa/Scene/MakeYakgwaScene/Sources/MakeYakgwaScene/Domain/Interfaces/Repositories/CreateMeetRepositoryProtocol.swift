//
//  CreateMeetRepositoryProtocol.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Network
import RxSwift

public protocol CreateMeetRepositoryProtocol {
    func createMeet(token: String, userId: Int, data: MakeMeetRequestDTO) -> Single<Bool>
}
