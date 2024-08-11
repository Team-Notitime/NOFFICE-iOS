////
////  AnnouncementRepository.swift
////  AnnouncementData
////
////  Created by DOYEON LEE on 7/31/24.
////
//
// import Foundation
// import RxSwift
//
// import AnnouncementEntity
//
// import RxMoya
// import Moya
//
// struct AnnouncementRepository {
//    private let provider = MoyaProvider<AnnouncementTarget>()
//    
//    // Initialize with a MoyaProvider
//    init(provider: MoyaProvider<AnnouncementTarget>) {
//        self.provider = provider
//    }
//    
//    // Fetch a specific announcement by ID
//    public func getAnnouncement(id: Int) -> Observable<AnnouncementEntity> {
//        return provider.rx.request(.(id: id))
//            .catch { error -> Single<Response> in
//                return .error(AnnouncementError.underlying(error))
//            }
//            .filterSuccessfulStatusCodes()
//            .map(GetAnnouncementResponse.self)
//            .map { response in
//                GetAnnouncementConverter.convert(
//                    from: response,
//                    memberId: 0
//                ) // Provide memberId as needed
//            }
//            .asObservable()
//    }
//    
//    // Create a new announcement
//    public func createAnnouncement(
//        announcement: AnnouncementEntity,
//        memberId: Int
//    ) -> Observable<AnnouncementEntity> {
//        let requestDTO = CreateAnnouncementConverter.convert(from: announcement, memberId: memberId)
//        
//        return provider.rx.request(.createAnnouncement(requestDTO))
//            .catch { error -> Single<Response> in
//                return .error(AnnouncementError.underlying(error))
//            }
//            .filterSuccessfulStatusCodes()
//            .map(CreateAnnouncementDTO.Response.self)
//            .map { _ in
//                // Convert the response to an AnnouncementEntity if needed
//                // Assuming CreateAnnouncementConverter can handle this if it needs to
//                // Or fetch the announcement again if needed
//                announcement // Return the original announcement if no conversion is needed
//            }
//            .asObservable()
//    }
//    
//    // Update an existing announcement
//    public func updateAnnouncement(
//        announcement: AnnouncementEntity
//    ) -> Observable<AnnouncementEntity> {
//        let requestDTO = UpdateAnnouncementConverter.convert(from: announcement)
//        
//        return provider.rx.request(.updateAnnouncement(requestDTO))
//            .catch { error -> Single<Response> in
//                return .error(AnnouncementError.underlying(error))
//            }
//            .filterSuccessfulStatusCodes()
//            .map(UpdateAnnouncementDTO.Response.self)
//            .map { _ in
//                // Convert the response to an AnnouncementEntity if needed
//                // Assuming UpdateAnnouncementConverter can handle this if it needs to
//                // Or fetch the announcement again if needed
//                announcement // Return the original announcement if no conversion is needed
//            }
//            .asObservable()
//    }
//    
//    // Delete an announcement by ID
//    public func deleteAnnouncement(id: Int) -> Observable<Bool> {
//        return provider.rx.request(.deleteAnnouncement(id: id))
//            .catch { error -> Single<Response> in
//                return .error(AnnouncementError.underlying(error))
//            }
//            .filterSuccessfulStatusCodes()
//            .map { _ in true }
//            .catch { _ in .just(false) }
//            .asObservable()
//    }
// }
