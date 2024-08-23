//
//  GetTodosByOrganizationUsecase.swift
//  TodoUsecase
//
//  Created by DOYEON LEE on 8/23/24.
//

import RxSwift

public struct GetTodosByOrganizationUsecase {
    // MARK: DTO
    public struct Input {
        public init() { }
    }
    
    public struct Output { }
    
    // MARK: Dependency
    
    
    // MARK: Initializer
    public init() { }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        let outputObservable = Observable.just(Output())
        return outputObservable
    }
}
