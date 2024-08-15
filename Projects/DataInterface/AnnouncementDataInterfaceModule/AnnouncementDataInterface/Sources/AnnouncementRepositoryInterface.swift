//
//  AnnouncementRepositoryInterface.swift
//  AnnouncementDataInterface
//
//  Created by DOYEON LEE on 8/15/24.
//

import OpenapiGenerated

import RxSwift

public typealias CreateAnnounementParam = Components.Schemas.AnnouncementCreateRequest
public typealias CreateAnnouncementResult = Components.Schemas.AnnouncementResponse

public typealias GetAnnouncementParam = Operations.getAnnouncement.Input.Path
public typealias GetAnnouncementResult = Components.Schemas.AnnouncementResponse

public struct UpdateAnnouncementParam {
    public let announcementId: Int64
    public let updatedAnnoundement: Components.Schemas.AnnouncementUpdateRequest
    
    public init(
        announcementId: Int64,
        updatedAnnoundement: Components.Schemas.AnnouncementUpdateRequest
    ) {
        self.announcementId = announcementId
        self.updatedAnnoundement = updatedAnnoundement
    }
}
public typealias UpdateAnnouncementResult = Components.Schemas.AnnouncementResponse

public protocol AnnouncementRepositoryInterface {
    func createAnnouncement(_ param: CreateAnnounementParam) -> Observable<CreateAnnouncementResult>
    func getAnnouncement(_ param: GetAnnouncementParam) -> Observable<GetAnnouncementResult>
    func updateAnnouncement(_ param: UpdateAnnouncementParam) -> Observable<UpdateAnnouncementResult>
    func deleteAnnouncement(_ announcementId: Int64) -> Observable<Void>
}
