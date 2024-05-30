//
//  File.swift
//  
//
//  Created by Ekko on 5/27/24.
//

import Foundation

import Moya
import RxMoya
import RxSwift

/// Base Remote Data Source
/// Moya Provider를 이용한 API 호출을 위한 기본 클래스
open class BaseRemoteDataSource<API: YakgwaAPI> {
    private let provider: MoyaProvider<API>
    private let maxRetryCount = 2
    
    public init(provider: MoyaProvider<API>? = nil) {
        self.provider = provider ?? MoyaProvider()
    }
    
    public func request(_ api: API) -> Single<Response> {
        return defaultRequest(api)
    }
}

private extension BaseRemoteDataSource {
    func defaultRequest(_ api: API) -> Single<Response> {
        return provider.rx.request(api)
            .timeout(.seconds(10), scheduler: MainScheduler.asyncInstance)
            .retry(maxRetryCount)
            .flatMap { response -> Single<Response> in
                return .just(response)
            }
            .catch { error in
                guard let moyaError = error as? MoyaError,
                      let errorCode = moyaError.response?.statusCode else {
                    if let moyaError = error as? MoyaError, moyaError.errorCode == 6 {
                        return Single.error(api.errorMap[1009] ?? error)
                    }
                    return Single.error(error)
                }
                return Single.error(api.errorMap[errorCode] ?? error)
            }
    }
}

/*
open class BaseRemoteDataSource<API: YakgwaAPI> {
    private let provider: MoyaProvider<API>
    private let maxRetryCount = 2

    public init(
        provider: MoyaProvider<API>? = nil
    ) {
        self.provider = provider ?? MoyaProvider()
    }

    public func request(_ api: API) -> Single<Response> {
        print("요청: \(api)")
        return Single<Response>.create { single in
            var disposables = [Disposable]()
            disposables.append(
                    self.defaultRequest(api).subscribe(
                        onSuccess: { single(.success($0)) },
                        onFailure: {
                            return single(.failure($0))
                        }
                )
            )
            return Disposables.create(disposables)
        }
    }
}

private extension BaseRemoteDataSource {
    func defaultRequest(_ api: API) -> Single<Response> {
        return provider.rx.request(api)
            .timeout(.seconds(10), scheduler: MainScheduler.asyncInstance)
            .retry(maxRetryCount)
            .catch { error in
                guard let errorCode = (error as? MoyaError)?.response?.statusCode else {
                    if let moyaError = (error as? MoyaError), moyaError.errorCode == 6 {
                        return Single.error(api.errorMap[1009] ?? error)
                    }
                    return Single.error(error)
                }
                return Single.error(api.errorMap[errorCode] ?? error)
            }
    }
}
*/
