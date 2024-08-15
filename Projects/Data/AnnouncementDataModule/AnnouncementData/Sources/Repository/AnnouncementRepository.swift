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
        transport: URLSessionTransport()
    )
    
    public init() {}
    
    public func createAnnouncement(
        _ param: CreateAnnounementParam
    ) -> Observable<CreateAnnouncementResult> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.createAnnouncement(
                        .init(
                            body: .json(param)
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
        _ param: GetAnnouncementParam
    ) -> Observable<CreateAnnouncementResult> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getAnnouncement(
                        .init(
                            path: param
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
        _ param: UpdateAnnouncementParam
    ) -> Observable<UpdateAnnouncementResult> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.updateAnnouncement(
                        .init(
                            path: .init(announcementId: param.announcementId),
                            body: .json(param.updatedAnnoundement)
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
        _ announcementId: Int64
    ) -> Observable<Void> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.deleteAnnouncement(
                        .init(
                            path: .init(announcementId: announcementId)
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
}
