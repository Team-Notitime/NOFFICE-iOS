//
//  MemberRepositoryImpl.swift
//  MemberData
//
//  Created by DOYEON LEE on 8/12/24.
//

import Foundation

import OpenapiGenerated
import MemberEntity
import MemberDataInterface

import OpenAPIURLSession
import RxSwift

public struct MemberRepositoryImpl: MemberRepository {
    private let client: APIProtocol = Client(
        serverURL: UrlConfig.baseUrl.url,
        transport: URLSessionTransport()
    )
    
    public init() {}
    
    public func getMember(param: GetMemberParam) -> Observable<GetMemberResult> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getMember(param)
                    
                    if let data = try response.ok.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(MemberError.invalidResponse)
                    }
                } catch {
                    observer.onError(MemberError.underlying(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
