//
//  MemberRepositoryImpl.swift
//  MemberData
//
//  Created by DOYEON LEE on 8/12/24.
//

import CommonData
import Foundation
import MemberDataInterface
import MainEntity
import OpenapiGenerated
import OpenAPIURLSession
import RxSwift

public struct MemberRepository: MemberRepositoryInterface {
    private let authenticatedClient: APIProtocol
    private let publicClient: APIProtocol
  
    public init() {
        self.authenticatedClient = Client(
           serverURL: UrlConfig.baseUrl.url,
           configuration: .init(dateTranscoder: .custom),
           transport: URLSessionTransport(),
           middlewares: [
            AuthenticationMiddleware(),
            TokenRefreshingMiddleware()
           ]
       )
      
      self.publicClient = Client(
        serverURL: UrlConfig.baseUrl.url,
        configuration: .init(dateTranscoder: .custom),
        transport: URLSessionTransport()
    )
    }
    
    public func getMember(_ request: GetMemberRequest) -> Observable<GetMemberResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await authenticatedClient.getById(request)
                    
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
    
    public func login(_ request: LoginRequest) -> Observable<LoginResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await publicClient.login(request)
                    
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
    
    public func reissue(_ request: ReissueRequest) -> Observable<ReissueResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await publicClient.reissue(request)
                    
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
    
    public func withdrawal(_ request: WithdrawalRequest) -> Observable<WithdrawalResponse> {
        return Observable.create { observer in
            Task {
                do {
                  let response = try await authenticatedClient.withdrawal(request)
                    
                    if let data = try response.noContent.body.json.data {
                        observer.onNext(())
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
  
    public func rename(_ request: RenameRequest) -> Observable<RenameResponse> {
      return Observable.create { observer in
        Task {
          do {
            let response = try await authenticatedClient.updateName(request)
            
            if let data = try response.noContent.body.json.data {
              observer.onNext(())
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
