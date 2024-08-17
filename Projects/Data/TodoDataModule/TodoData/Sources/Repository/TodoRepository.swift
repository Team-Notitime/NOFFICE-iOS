//
//  TodoRepository.swift
//  TodoData
//
//  Created by DOYEON LEE on 8/15/24.
//

import Foundation

import CommonData
import TodoDataInterface
import OpenapiGenerated

import OpenAPIURLSession

/// A repository that handles network communication with the server related to the organization domain.
public struct TodoRepository: TodoRepositoryInterface {
    private let client: APIProtocol
    
    public init() {
        self.client = Client(
           serverURL: UrlConfig.baseUrl.url,
           transport: URLSessionTransport(),
           middlewares: [AuthenticationMiddleware()]
       )
    }
//    
//    public func createTodo(
//        _ param: GetOrganizationParam
//    ) -> Observable<GetOrganizationResult> {
//        return Observable.create { observer in
//            Task {
//                do {
//                    let response = try await client.createTask(.init(path: param))
//                    
//                    if let data = try response.ok.body.json.data {
//                        observer.onNext(data)
//                        observer.onCompleted()
//                    } else {
//                        observer.onError(OrganizationError.invalidResponse)
//                    }
//                } catch {
//                    observer.onError(OrganizationError.underlying(error))
//                }
//            }
//            
//            return Disposables.create()
//        }
//    }
}
