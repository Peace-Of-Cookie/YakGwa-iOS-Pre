//
//  CreateMeetUseCase.swift
//
//
//  Created by Ekko on 6/5/24.
//

import Network
import RxSwift

public protocol CreateMeetUseCaseProtocol {
    func execute(token: String, userId: Int, data: MakeMeetRequestDTO) -> Single<Int>
}

public final class CreateMeetUseCase: CreateMeetUseCaseProtocol {
    
    private let repository: CreateMeetRepositoryProtocol
    
    public init(repository: CreateMeetRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(token: String, userId: Int, data: MakeMeetRequestDTO) -> Single<Int> {
        return repository.createMeet(token: token, userId: userId, data: data)
    }
}
