//
//  CreateAnnouncementUsecase.swift
//  AnnouncementUsecase
//
//  Created by DOYEON LEE on 8/19/24.
//

import AnnouncementDataInterface
import AnnouncementEntity
import Container
import Foundation
import RxSwift
import Swinject
import UserDefaultsUtility

public struct CreateAnnouncementUsecase {
    // MARK: DTO

    public struct Input {
        let newAnnouncement: NewAnnouncementEntity
        
        public init(
            newAnnouncement: NewAnnouncementEntity
        ) {
            self.newAnnouncement = newAnnouncement
        }
    }
    
    public struct Output {
        public let announcementId: Int
    }
    
    // MARK: Dependency

    let announcementRepository = Container.shared
        .resolve(AnnouncementRepositoryInterface.self)!
    
    let memberUserDefaultsManager = UserDefaultsManager<Member>()
    
    // MARK: Initializer
    public init() {}
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        guard let member = memberUserDefaultsManager.get() else {
            fatalError("해당 유즈케이스는 로그인 상태에서 실행되어야합니다.")
        }

        let newAnnouncement = input.newAnnouncement

        let autoGeneratedEndAt = generateAutoEndDate()
        
        let (noticeBefore, noticeDate) = parseNotificationDates(
            from: newAnnouncement.notifications
        )

        return announcementRepository
            .createAnnouncement(
                .init(
                    organizationId: newAnnouncement.organizationId,
                    memberId: member.id,
                    title: newAnnouncement.title,
                    content: newAnnouncement.body,
                    tasks: (newAnnouncement.todos ?? [])
                        .map { .init(content: $0) },
                    endAt: newAnnouncement.endAt ?? autoGeneratedEndAt,
                    noticeBefore: noticeBefore,
                    noticeDate: noticeDate
                )
            )
            .map { result in
                Output(announcementId: Int(result.announcementId ?? 0))
            }
    }

    // MARK: Private method
    private func generateAutoEndDate() -> Date {
        Calendar.current.date(byAdding: .month, value: 1, to: Date())!
    }

    private func parseNotificationDates(
        from notifications: [AnnouncementRemindNotification]?
    ) -> ([Date], [Date]) {
        return (notifications ?? [])
            .reduce(into: ([Date](), [Date]())) { result, notification in
                switch notification {
                case let .before(timeInterval):
                    let date = Date().addingTimeInterval(-timeInterval)
                    result.0.append(date)

                case let .custom(date):
                    result.1.append(date)
                }
            }
    }
}
