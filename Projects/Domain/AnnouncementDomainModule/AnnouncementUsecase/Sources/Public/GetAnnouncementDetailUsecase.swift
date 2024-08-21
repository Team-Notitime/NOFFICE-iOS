//
//  GetAnnouncementDetailUsecase.swift
//  AnnouncementUsecase
//
//  Created by DOYEON LEE on 7/26/24.
//

import Foundation

import AnnouncementEntity
import AnnouncementDataInterface
import Container

import Swinject
import RxSwift

public struct GetAnnouncementDetailUsecase {
    // MARK: DTO
    public struct Input {
        let announcementId: Int64
        
        public init(
            announcementId: Int64
        ) {
            self.announcementId = announcementId
        }
    }
    
    public struct Output { 
        public let announcement: AnnouncementEntity
    }
    
    // MARK: Dependency
    private let announcementRepository = Container.shared
        .resolve(AnnouncementRepositoryInterface.self)!
    
    // MARK: Initializer
    public init() { }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        let outputObservable = announcementRepository
            .getAnnouncement(
                .init(announcementId: input.announcementId)
            )
            .map { result in
                Output(
                    announcement: AnnouncementEntity(
                        id: result.announcementId ?? 0,
                        organizationId: result.organizationId ?? 0,
                        title: result.title ?? "",
                        body: result.content ?? "",
                        endAt: result.endAt,
                        place: .init(
                            type: .offline, // TODO: 스키마 추가 필요
                            name: result.placeLinkName,
                            link: result.placeLinkUrl ?? ""
                        )
                    )
                )
            }
        
        return outputObservable
    }
}

// MARK: - Mock
private struct Mock {
    static let annoucement = AnnouncementEntity(
        id: 11412312,
        organizationId: 1,
        createdAt: Date.now,
        title: "5차 세션 : 최종 팀 빌딩 ~ 제목이 두 줄 일 때",
        body: """
                15기 챌린저 전원이 함께 모여 작업할 수 있는 모각작 세션과 UT(User Test)가 진행됩니다.
                User Test는 실제 사용자가 서비스를 테스트하며 피드백하는 중요한 과정입니다. 사용자가 주어진 작업을 완료하는 데 걸리는 시간을 관찰하는 등의 방법을 통해 사용성을 평가하고, 피드백을 받아 서비스를 더욱 더 발전시킬 수 있습니다.
                사용자를 이해하는 과정을 통해 다양한 인사이트를 얻을 수 있으면 좋겠습니다.  이번 모각작 UT는 Maze로 진행합니다. 프로토타입을 만들어서 Maze 링크를 만들어 배포하시면 됩니다. [단, UT 세션 진행 전에 7/27에 진행할 UT 링크를 절대 배포하지 마세요.]
                """,
        endAt: Date.now,
        place: .init(
            type: .offline,
            name: "서울 창업 허브 : 장소 이름이름이름이름..",
            link: "https://naver.com"
        ),
        todos: [
            .init(id: 1, content: "과제 제출", status: .pending),
            .init(id: 2, content: "과제 제출 2", status: .pending)
        ]
    )
}
