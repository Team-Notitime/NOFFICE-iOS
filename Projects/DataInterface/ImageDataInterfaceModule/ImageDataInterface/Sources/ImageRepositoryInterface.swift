//
//  ImageRepositoryInterface.swift
//  ImageDataInterface
//
//  Created by DOYEON LEE on 8/25/24.
//

import RxSwift

public protocol ImageRepositoryInterface {
    func getImageUploadPath(
        _ request: GetImageUploadPathRequest
    ) -> Observable<GetImageUploadPathResponse>
    
    func notifyImageUploadComplete(
        _ request: NotifyImageUploadCompleteRequest
    ) -> Observable<NotifyImageUploadCompleteResponse>
}
