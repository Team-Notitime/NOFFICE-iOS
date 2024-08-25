//
//  ImageRepository.swift
//  ImageData
//
//  Created by DOYEON LEE on 8/25/24.
//

import OpenapiGenerated
import ImageDataInterface
import CommonData

import OpenAPIURLSession
import RxSwift

public struct ImageRepository: ImageRepositoryInterface {
    private let client: APIProtocol
    
    public init() {
        self.client = Client(
           serverURL: UrlConfig.baseUrl.url,
           configuration: .init(dateTranscoder: .custom),
           transport: URLSessionTransport(),
           middlewares: [AuthenticationMiddleware()]
       )
    }
    
    public func getImageUploadPath(
        _ request: GetImageUploadPathRequest
    ) -> Observable<GetImageUploadPathResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.getContentImage(
                        .init(query: request)
                    )

                    let data = try response.ok.body.json
                    
                    observer.onNext(data)
                    observer.onCompleted()
                } catch {
                    observer.onError(ImageError.underlying(error))
                }
            }

            return Disposables.create()
        }
    }

    public func notifyImageUploadComplete(
        _ request: NotifyImageUploadCompleteRequest
    ) -> Observable<NotifyImageUploadCompleteResponse> {
        return Observable.create { observer in
            Task {
                do {
                    let response = try await client.notifyContentImageSaveSuccess(
                        body: request
                    )

                    let data = try response.ok

                    observer.onNext(())
                    observer.onCompleted()
                } catch {
                    observer.onError(ImageError.underlying(error))
                }
            }

            return Disposables.create()
        }
    }
}
