//
//  FetchOpenGraphUsecase.swift
//  AnnouncementUsecase
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import AnnouncementEntity

import RxSwift
import OpenGraph

public struct FetchOpenGraphUsecase {
    
    public init() { }
    
    public func execute(url: String) -> Observable<OpenGraphEntity> {
        guard let url = URL(string: url) else {
            return Observable.error(
                NSError(domain: "Invalid URL", code: -1, userInfo: nil)
            )
        }
        
        return Observable.create { observer in
            OpenGraph.fetch(url: url) { result in
                switch result {
                case .success(let og):
                    let entity = OpenGraphEntity(
                        title: og[.title] ?? "",
                        type: og[.type] ?? "",
                        imageURL: og[.image] ?? "",
                        url: og[.url] ?? url.absoluteString
                    )
                    observer.onNext(entity)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
