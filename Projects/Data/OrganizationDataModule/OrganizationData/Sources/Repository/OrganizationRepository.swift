//
//  OrganizationRepository.swift
//  OrganizationData
//
//  Created by DOYEON LEE on 7/29/24.
//

import Foundation

import OpenapiGenerated
import OrganizationEntity
import OrganizationDataInterface
import CommonData

import OpenAPIURLSession
import RxSwift

/// A repository that handles network communication with the server related to the organization domain.
public struct OrganizationRepository: OrganizationRepositoryInterface {
    private let client: APIProtocol = Client(
        serverURL: UrlConfig.baseUrl.url,
        transport: URLSessionTransport()
    )
    
    public init() {}
    
    public func getOrganization(
        _ param: GetOrganizationParam
    ) -> Observable<GetOrganizationResult> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getOrganization(.init(path: param))
                    
                    if let data = try response.ok.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(OrganizationError.invalidResponse)
                    }
                } catch {
                    observer.onError(OrganizationError.underlying(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    public func getJoinedOrganizations(
        _ param: GetJoinedOrganizationsParam
    ) -> Observable<GetJoinedOrganizationsResult> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getJoinedOrganizations(param)
                    
                    if let data = try response.ok.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(OrganizationError.invalidResponse)
                    }
                } catch {
                    observer.onError(OrganizationError.underlying(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    public func getPublishedAnnouncements(
        _ param: GetPublishedAnnouncementParam
    ) -> Observable<GetPublishedAnnouncementResult> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getPublishedAnnouncements(
                        .init(
                            path: .init(organizationId: param.organizationId),
                            query: .init(
                                memberId: param.memberId,
                                pageable: param.pageable
                            )
                        )
                    )
                    
                    if let data = try response.ok.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(OrganizationError.invalidResponse)
                    }
                } catch {
                    observer.onError(OrganizationError.underlying(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    public func createOrganization(
        _ param: CreateOrganizationParam
    ) -> Observable<CreateOrganizationResult> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.createOrganization(
                        .init(
                            query: .init(memberId: param.memberId),
                            body: .json(param.body)
                        )
                    )
                    
                    if let data = try response.created.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(OrganizationError.invalidResponse)
                    }
                } catch {
                    observer.onError(OrganizationError.underlying(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
