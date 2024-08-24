//
//  _GetAnnouncementsByOrganizationUsecase.swift
//  AnnouncementUsecase
//
//  Created by DOYEON LEE on 8/1/24.
//

import Foundation

import Container
import OrganizationEntity
import AnnouncementEntity
import OrganizationDataInterface

import Swinject
import RxSwift

final class _GetAnnouncementsByOrganizationUsecase {
    // MARK: DTO
    public struct Input {
        public let organizationId: Int64
        
        public init(organizationId: Int64) {
            self.organizationId = organizationId
        }
    }
    
    public struct Output { 
        public let announcements: [AnnouncementSummaryEntity]
    }
    
    // MARK: Error
    public enum Error: LocalizedError {
        case contentFieldNotFound
    }
    
    // MARK: Property
    private var page: Int
    
    // MARK: Dependency
    private let organizationRepository = Container.shared.resolve(OrganizationRepositoryInterface.self)!
    
    // MARK: Initializer
    public init() { 
        page = Constant.StartPage
    }
    
    // MARK: Execute method
    public func execute(_ input: Input) -> Observable<Output> {
        
        let outputObservable = organizationRepository.getPublishedAnnouncements(
            .init(
                organizationId: Int64(input.organizationId),
                pageable: .init(page: Int32(page), size: Constant.PageSize)
            )
        )
            .withUnretained(self)
            .flatMap { _, result -> Observable<Output> in
                if let content = result.content {
//                    owner.page += 1 // TODO: v1.1.0에 페이징 로직 추가
                    
                    let announcements = content.map {
                        AnnouncementSummaryEntity(
                            id: $0.announcementId ?? -1,
                            organizationId: input.organizationId,
                            imageUrl: $0.profileImageUrl,
                            createdAt: $0.createdAt,
                            title: $0.title ?? "",
                            body: $0.content ?? "",
                            endAt: $0.endAt,
                            placeName: $0.placeLinkName,
                            todoCount: 0 // todo 조회 API 사용? 같이 담아줄 수 있는지 요청 필요
                        )
                    }
                    
                    return Observable.just(Output(announcements: announcements))
                } else {
                    return Observable.error(Error.contentFieldNotFound)
                }
            }
        
        return outputObservable
    }
}

// MARK: - Mock
private struct Mock {
    static let AnnouncementEntities: [AnnouncementEntity] = [
        .init(
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
            todos: []
        ),
        .init(
            id: 11412313,
            organizationId: 1,
            createdAt: Date.now,
            title: "6차 세션 : 프로젝트 중간 점검 및 피드백",
            body: """
            이번 세션에서는 각 팀의 프로젝트 진행 상황을 점검하고 피드백을 나눕니다.
            멘토들과 함께 현재까지의 성과를 리뷰하고, 앞으로의 방향성에 대해 논의할 예정입니다.
            팀별로 10분간 프레젠테이션을 진행한 후, 20분간 Q&A 및 피드백 시간이 주어집니다.
            이를 통해 프로젝트의 완성도를 높이고, 새로운 아이디어를 얻을 수 있는 기회가 될 것입니다.
            """,
            endAt: Date.now.addingTimeInterval(7 * 24 * 60 * 60),
            place: .init(
                type: .online,
                name: "구글 밋",
                link: "https://meet.google.com/abc-defg-hij"
            ),
            todos: [
                .init(id: 1, content: "프레젠테이션 자료 준비", status: .pending),
                .init(id: 2, content: "팀 미팅 진행", status: .done),
                .init(id: 3, content: "팀 미팅 진행상황 보고", status: .done),
                .init(id: 4, content: "피드백 문서 정리", status: .pending),
                .init(id: 5, content: "테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집 테스터 모집", status: .done)
            ]
        ),

        .init(
            id: 11412314,
            organizationId: 1,
            createdAt: Date.now,
            title: "7차 세션 : UI/UX 디자인 워크샵",
            body: """
            UI/UX 전문가를 모시고 실제 프로젝트에 적용할 수 있는 디자인 원칙과 트렌드에 대해 배웁니다.
            이론 강의 후에는 각 팀의 프로젝트에 대한 1:1 컨설팅이 진행됩니다.
            사용자 중심의 디자인 사고방식을 익히고, 프로토타이핑 도구 사용법도 함께 학습할 예정입니다.
            """,
            endAt: Date.now.addingTimeInterval(14 * 24 * 60 * 60),
            place: .init(
                type: .online,
                name: "Zoom 화상회의",
                link: "https://zoom.us/j/1234567890"
            ),
            todos: [
                .init(id: 1, content: "현재 UI 스크린샷 준비", status: .pending),
                .init(id: 2, content: "디자인 관련 질문 리스트 작성", status: .pending)
            ]
        ),

        .init(
            id: 11412315,
            organizationId: 1,
            createdAt: Date.now,
            title: "8차 세션 : 데이터 분석과 인공지능 활용 특강",
            body: """
            데이터 사이언티스트를 초빙하여 프로젝트에 데이터 분석과 AI를 접목하는 방법에 대해 배웁니다.
            기초적인 통계 분석부터 머신러닝 모델 적용까지, 다양한 레벨의 내용을 다룰 예정입니다.
            세션 후반부에는 각 팀의 프로젝트에 어떻게 이 기술들을 적용할 수 있을지 토론합니다.
            """,
            endAt: Date.now.addingTimeInterval(21 * 24 * 60 * 60),
            todos: [
                .init(id: 1, content: "데이터셋 준비", status: .pending),
                .init(id: 2, content: "Python 기초 학습", status: .done)
            ]
        ),

        .init(
            id: 11412316,
            organizationId: 1,
            createdAt: Date.now,
            title: "9차 세션 : 창업과 비즈니스 모델 구축",
            body: """
            스타트업 창업자와 벤처 캐피탈리스트를 모시고 실제 창업 과정과 비즈니스 모델 구축에 대해 이야기 나눕니다.
            아이디어를 어떻게 수익화할 수 있는지, 투자를 받기 위해 필요한 것들은 무엇인지 등 실질적인 내용을 다룹니다.
            각 팀은 자신들의 프로젝트에 대한 비즈니스 모델 캔버스를 작성하고 발표하는 시간을 가집니다.
            """,
            endAt: Date.now.addingTimeInterval(28 * 24 * 60 * 60),
            place: .init(
                type: .offline,
                name: "서울 스타트업 허브",
                link: "https://meet.google.com/jkl-mnop-qrs"
            ),
            todos: [
                .init(id: 1, content: "비즈니스 모델 캔버스 초안 작성", status: .pending)
            ]
        ),

        .init(
            id: 11412317,
            organizationId: 1,
            createdAt: Date.now,
            title: "10차 세션 : 최종 프로젝트 발표 및 데모 데이",
            body: """
            15기 챌린저들의 3개월간의 여정이 마무리되는 최종 발표회입니다.
            각 팀은 20분간 프로젝트 시연과 발표를 진행하고, 10분간 Q&A 시간을 가집니다.
            업계 전문가들로 구성된 심사위원단의 평가를 통해 우수 프로젝트를 선정하며,
            네트워킹 시간을 통해 다양한 분야의 전문가들과 교류할 수 있는 기회가 주어집니다.
            """,
            endAt: Date.now.addingTimeInterval(35 * 24 * 60 * 60),
            place: .init(
                type: .offline,
                name: "코엑스 컨퍼런스룸",
                link: "https://maps.google.com/?q=COEX+Conference+Room"
            ),
            todos: [
                .init(id: 1, content: "발표 자료 최종 점검", status: .pending),
                .init(id: 2, content: "데모 리허설", status: .pending)
            ]
        )
    ]
}

// MARK: - Constant
private enum Constant {
    static let StartPage: Int = 0
    static let PageSize: Int32 = 10
}
