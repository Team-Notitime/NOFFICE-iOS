//
//  AnnouncementRepositoryInterface.swift
//  AnnouncementDataInterface
//
//  Created by DOYEON LEE on 8/15/24.
//

import OpenapiGenerated
import RxSwift

public protocol AnnouncementRepositoryInterface {
    func createAnnouncement(
        _ request: CreateAnnounementRequest
    ) -> Observable<CreateAnnouncementResponse>

    func getAnnouncement(
        _ request: GetAnnouncementRequest
    ) -> Observable<GetAnnouncementResponse>

    func updateAnnouncement(
        _ request: UpdateAnnouncementRequest
    ) -> Observable<UpdateAnnouncementResponse>

    func deleteAnnouncement(
        _ request: DeleteAnnouncementRequest
    ) -> Observable<DeleteAnnouncementResponse>
}
