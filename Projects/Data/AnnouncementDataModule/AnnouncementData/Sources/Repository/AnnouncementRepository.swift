//
//  AnnouncementRepository.swift
//  AnnouncementData
//
//  Created by DOYEON LEE on 7/31/24.
//

import Foundation

import OpenapiGenerated
import AnnouncementEntity
import AnnouncementDataInterface
import CommonData

import OpenAPIURLSession
import RxSwift

public struct AnnouncementRepository: AnnouncementRepositoryInterface {
    private let client: APIProtocol = Client(
        serverURL: UrlConfig.baseUrl.url,
        configuration: .init(dateTranscoder: .custom),
        transport: URLSessionTransport(),
        middlewares: [
            AuthenticationMiddleware(),
            TokenRefreshingMiddleware()
        ]
    )
    
    public init() {}
    
    public func createAnnouncement(
        _ request: CreateAnnounementRequest
    ) -> Observable<CreateAnnouncementResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.create_2(
                        .init(
                            body: .json(request)
                        )
                    )
                    
                    if let data = try response.created.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(AnnouncementError.invalidResponse)
                    }
                } catch {
                    observer.onError(AnnouncementError.underlying(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    public func getAnnouncement(
        _ request: GetAnnouncementRequest
    ) -> Observable<GetAnnouncementResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.read(
                        .init(
                            path: request
                        )
                    )
                    
                    if let data = try response.ok.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(AnnouncementError.invalidResponse)
                    }
                } catch {
                    observer.onError(AnnouncementError.underlying(error))
                }
            }
            return Disposables.create()
        }
    }
    
    public func updateAnnouncement(
        _ request: UpdateAnnouncementRequest
    ) -> Observable<UpdateAnnouncementResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.update(
                        .init(
                            path: .init(announcementId: request.announcementId),
                            body: .json(request.updatedAnnoundement)
                        )
                    )
                    
                    if let data = try response.ok.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(AnnouncementError.invalidResponse)
                    }
                } catch {
                    observer.onError(AnnouncementError.underlying(error))
                }
            }
            return Disposables.create()
        }
    }
    
    public func deleteAnnouncement(
        _ request: DeleteAnnouncementRequest
    ) -> Observable<DeleteAnnouncementResponse> {
        return Observable.create { observer in
            Task {
                do {
                    _ = try await client.delete_1(
                        .init(
                            path: .init(
                                announcementId: request.announcementId
                            )
                        )
                    )
                    
                    observer.onNext(())
                    observer.onCompleted()
                } catch {
                    observer.onError(AnnouncementError.underlying(error))
                }
            }
            return Disposables.create()
        }
    }

    public func getTodosByAnnouncement(
        _ request: GetTodosByAnnouncementRequest
    ) -> Observable<GetTodosByAnnouncementResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getTasksById(
                        .init(
                            path: request
                        )
                    )
                    
                    if let data = try response.ok.body.json.data {
                        observer.onNext(data)
                        observer.onCompleted()
                    } else {
                        observer.onError(AnnouncementError.invalidResponse)
                    }
                    observer.onCompleted()
                } catch {
                    observer.onError(AnnouncementError.underlying(error))
                }
            }
            return Disposables.create()
        }
    }
}
