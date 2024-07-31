//
//  RxMap+Extension.swift
//  CommonData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Moya
import RxSwift

extension ObservableType where Element == Response {
    func filterClientErrors<E: Error>(
        errorType: @escaping (Error) -> E
    ) -> Observable<Element> {
        return flatMap { response -> Observable<Element> in
            if (400...499).contains(response.statusCode) {
                return Observable.error(errorType(response.statusCode))
            }
            return Observable.just(response)
        }
    }
    
    func filterServerErrors<E: Error>(
        errorType: @escaping (Error) -> E
    ) -> Observable<Element> {
        return flatMap { response -> Observable<Element> in
            if (500...599).contains(response.statusCode) {
                return Observable.error(errorType(response.statusCode))
            }
            return Observable.just(response)
        }
    }
}
