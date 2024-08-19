//
//  GetAllAnnouncementUsecase.swift
//  AnnouncementEntity
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import OrganizationDataInterface
import AnnouncementEntity
import Container

import Swinject
import RxSwift

public final class GetAllAnnouncementUsecase {
    // MARK: DTO
    public struct Input {
        public init() { }
    }
    
    public struct Output {
        public let announcements: [AnnouncementOrganizationEntity]
    }
    
    // MARK: Error
    public enum Error: LocalizedError {
        case organizationNotFound
    }
    
    // MARK: Property
    var page: Int
    
    // MARK: Dependency
    private let organizationRepository = Container.shared
        .resolve(OrganizationRepositoryInterface.self)!
    
    // MARK: Internal Usecase
    private var announcementUsecaseDict: [Int64: _GetAnnouncementsByOrganizationUsecase] = [:]
    
    // MARK: Initializer
    public init() { 
        page = Constant.StartPage
    }
    
    public func execute(_ input: Input) -> Observable<Output> {
        let param = GetJoinedOrganizationsParam(
            pageable: .init(
                page: Int32(page),
                size: Constant.PageSize
            )
        )

        return organizationRepository
            .getJoinedOrganizations(param)
            .flatMap { result -> Observable<Output> in
                guard let content = result.content else {
                    throw Error.organizationNotFound
                }

                // 각 organization마다 공지사항을 가져오기 위한 Observable 생성
                let announcementObservables = content.map { organization in
                    self.fetchAnnouncements(
                        organizationId: organization.organizationId,
                        organizationName: organization.organizationName
                    )
                }

                // 모든 Observable을 합쳐서 순차적으로 실행
                return Observable.zip(announcementObservables)
                    .map { announcementEntities in
                        Output(announcements: announcementEntities)
                    }
            }
    }

    private func fetchAnnouncements(
        organizationId: Int64,
        organizationName: String
    ) -> Observable<AnnouncementOrganizationEntity> {
        // _GetAnnouncementsByOrganizationUsecase 인스턴스 생성 및 실행
        let announcementUsecase = announcementUsecaseDict[organizationId] ?? _GetAnnouncementsByOrganizationUsecase()
        announcementUsecaseDict[organizationId] = announcementUsecase
        
        return announcementUsecase
            .execute(.init(organizationId: organizationId))
            .map { output in
                return AnnouncementOrganizationEntity(
                    id: Int(organizationId),
                    name: organizationName,
                    status: .join, // TODO: 실제 상태 판단 로직 필요
                    announcements: output.announcements
                )
            }
    }
}

// MARK: - Mock
private struct Mock {
//    static let announcements: [AnnouncementOrganizationEntity] = [
//        .init(
//            id: 1,
//            name: "CMC 15th",
//            status: .join,
//            announcements: [
//                .init(
//                    id: 1,
//                    organizationId: 1,
//                    title: "1차 모임 공지",
//                    body: """
//                    안녕하세요, 팀원 여러분!
//
//                    팀 멘토와 함께 신나고 즐거운 시간을 보낼 수 있도록 알찬 프로그램을 준비했답니다.
//
//                    1. 반가운 자기소개 & 아이스브레이킹!
//                       서로의 이름과 취미를 소개하면서, 재미있는 아이스브레이킹 게임도 할 거예요. 여러분의 숨겨진 매력을 마음껏 뽐내보세요!
//
//                    2. 프로젝트 개요와 일정 소개
//                       우리가 함께 할 프로젝트의 목표와 일정, 그리고 각자의 역할에 대해 멘토님이 친절하게 설명해주실 거예요. 궁금한 점이 있다면 언제든 질문해 주세요!
//
//                    3. 팀 빌딩 액티비티
//                       팀워크를 쑥쑥 키울 수 있는 활동이 기다리고 있어요! 함께 협력해서 문제를 해결하고, 팀으로서의 결속력을 다지는 시간이 될 거예요.
//
//                    이번 모임을 통해 우리 팀이 더욱 가까워지고, 프로젝트에 대한 이해도 깊어질 거라 믿어요. 부담 없이 오셔서 함께 즐거운 시간을 보내요!
//                    
//                    여러분의 많은 참석 부탁드려요. 감사합니다!
//                    """,
//                    endAt: Date.now,
//                    place: .init(
//                        type: .offline,
//                        name: "강남역",
//                        link: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=강남역"
//                    ),
//                    todos: [
//                        .init(id: 1, content: "즐거운 마음 준비!", status: .pending),
//                        .init(id: 2, content: "참여 여부 투표!", status: .pending)
//                    ]
//                ),
//                .init(
//                    id: 2,
//                    organizationId: 1,
//                    title: "5차 세션 : 최종 팀빌딩",
//                    body: """
//                    안녕하세요, 팀원 여러분!
//
//                    벌써 다섯 번째 세션이라니, 믿기시나요? 이번엔 드디어 최종 팀빌딩 시간이 찾아왔어요! 우리 팀의 결속력을 한층 더 높일 수 있는 신나는 시간!
//
//                    🕒 시간: 2024년 8월 5일 오후 3시
//                    📍 장소: 본사 3층 대회의실
//
//                    편하게 오셔서 함께 즐거운 시간 보내요! 기대할게요!
//
//                    - 팀 멘토 드림 😊
//                    """,
//                    endAt: Date.now,
//                    place: .init(
//                        type: .online,
//                        name: "ZEP",
//                        link: "https://zep.us/en"
//                    ),
//                    todos: [
//                        .init(id: 1, content: "📄 과제 제출", status: .pending),
//                        .init(id: 2, content: "✅ 과제 제출 확인 요청", status: .pending)
//                    ]
//                )
//            ]
//        ),
//        .init(
//            id: 3,
//            name: "즐거운 소모임",
//            status: .join,
//            announcements: []
//        ),
//        .init(
//            id: 4,
//            name: "행복한 스터디",
//            status: .pending,
//            announcements: []
//        )
//    ]
}

// MARK: - Constant
private enum Constant {
    static let StartPage: Int = 0
    static let PageSize: Int32 = 10
}
