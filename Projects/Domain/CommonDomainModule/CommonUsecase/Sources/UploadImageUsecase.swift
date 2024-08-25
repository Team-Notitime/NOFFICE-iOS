//
//  UploadImageUsecase.swift
//  CommonUsecase
//
//  Created by DOYEON LEE on 8/25/24.
//

import Foundation

import Container
import ImageDataInterface
import CommonEntity

import RxSwift
import Swinject

public struct UploadImageUsecase {
    // MARK: DTO
    public struct Input {
        let image: ImageEntity
        let imagePurpose: ImagePurpose
        
        public init(
            image: ImageEntity,
            imagePurpose: ImagePurpose
        ) {
            self.image = image
            self.imagePurpose = imagePurpose
        }
    }
    
    public struct Output { 
        public let url: URL?
    }
    
    public enum ImagePurpose: String {
        case organizationLogo = "ORGANIZATION_LOGO"
        case memberProfile = "MEMBER_PROFILE"
        case announcementProfile = "ANNOUNCEMENT_PROFILE"
        case announcementContent = "ANNOUNCEMENT_CONTENT"
        case promotionCover = "PROMOTION_COVER"
        
        static func from(rawValue: String) -> ImagePurpose? {
            return ImagePurpose(rawValue: rawValue)
        }
    }
    
    // MARK: Error
    enum Error: LocalizedError {
        case imageMetaDataParseError
    }
    
    // MARK: Dependency
    private let imageRepository = Container.shared.resolve(ImageRepositoryInterface.self)!
    
    // MARK: Initializer
    public init() { }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        guard let (name, type) = extractImageNameAndExtension(from: input.image.url) else {
            return .error(Error.imageMetaDataParseError)
        }
        
        return imageRepository
            .getImageUploadPath(
                .init(
                    fileType: type,
                    fileName: name,
                    imagePurpose: .init(rawValue: "\(input.imagePurpose.rawValue)")!
                )
            )
            .flatMap { uploadPathResponse in
                self.uploadImageData(
                    imageData: input.image.data,
                    type: type,
                    uploadUrlString: uploadPathResponse.urls?.url
                )
            }
            .flatMap { output in
                self.notifyImageUploadComplete(output: output)
            }
    }
    
    // MARK: Private method
    private func uploadImageData(
        imageData: Data,
        type: String,
        uploadUrlString: String?
    ) -> Observable<Output> {
        guard let uploadUrl = URL(string: uploadUrlString ?? "") else {
            return .error(Error.imageMetaDataParseError)
        }
        
        var request = URLRequest(url: uploadUrl)
        request.httpMethod = "PUT"
        request.setValue("image/\(type)", forHTTPHeaderField: "Content-Type")
        request.httpBody = imageData
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(Error.imageMetaDataParseError)
                    return
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    observer.onError(Error.imageMetaDataParseError)
                    return
                }
                
                observer.onNext(Output(url: uploadUrl))
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func notifyImageUploadComplete(output: Output) -> Observable<Output> {
        return imageRepository.notifyImageUploadComplete(
            .init(fileName: output.url?.absoluteString)
        ).map {
            output
        }
    }
    
    private func extractImageNameAndExtension(from url: URL) -> (name: String, extension: String)? {
        let fileName = url.lastPathComponent
        let fileExtension = url.pathExtension
        
        // 파일 이름과 확장자가 유효한지 확인
        guard !fileName.isEmpty, !fileExtension.isEmpty else {
            return nil
        }
        
        return (name: fileName, extension: fileExtension)
    }
}
