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

import OpenAPIRuntime
import OpenAPIURLSession
import RxSwift

/// A repository that handles network communication with the server related to the organization domain.
public struct OrganizationRepository: OrganizationRepositoryInterface {
    private let client: APIProtocol
    
    public init() {
        self.client = Client(
           serverURL: UrlConfig.baseUrl.url,
           configuration: .init(dateTranscoder: .custom),
           transport: URLSessionTransport(),
           middlewares: [AuthenticationMiddleware()]
       )
    }
    
    public func getOrganizationDetail(
        _ request: GetOrganizationDetailRequest
    ) -> Observable<GetOrganizationDetailResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getInformation(
                        .init(path: request)
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
    
    public func getJoinedOrganizations(
        _ request: GetJoinedOrganizationsRequest
    ) -> Observable<GetJoinedOrganizationsResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getJoined(
                        .init(query: request)
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
    
    public func getPublishedAnnouncements(
        _ request: GetPublishedAnnouncementRequest
    ) -> Observable<GetPublishedAnnouncementResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getPublishedAnnouncements(
                        .init(
                            path: .init(organizationId: request.organizationId),
                            query: .init(
                                pageable: request.pageable
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
        _ request: CreateOrganizationRequest
    ) -> Observable<CreateOrganizationResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.create(
                        .init(
                            body: .json(request.body)
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
