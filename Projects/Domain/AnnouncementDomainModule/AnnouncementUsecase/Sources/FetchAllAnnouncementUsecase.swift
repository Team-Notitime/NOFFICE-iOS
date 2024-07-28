//
//  FetchAllAnnouncementUsecase.swift
//  AnnouncementEntity
//
//  Created by DOYEON LEE on 7/22/24.
//

import Foundation

import AnnouncementEntity

import RxSwift

public struct FetchAllAnnouncementUsecase {
    
    public init() { }
    
    public func execute() -> Observable<[AnnouncementOrganizationEntity]> {
        let mock: [AnnouncementOrganizationEntity] = [
            .init(
                id: 1,
                name: "CMC 15th",
                status: .join,
                announcements: [
                    .init(
                        id: 1,
                        title: "1차 모임 공지",
                        body: """
                        안녕하세요, 팀원 여러분!

                        팀 멘토와 함께 신나고 즐거운 시간을 보낼 수 있도록 알찬 프로그램을 준비했답니다.

                        1. 반가운 자기소개 & 아이스브레이킹!
                           서로의 이름과 취미를 소개하면서, 재미있는 아이스브레이킹 게임도 할 거예요. 여러분의 숨겨진 매력을 마음껏 뽐내보세요!

                        2. 프로젝트 개요와 일정 소개
                           우리가 함께 할 프로젝트의 목표와 일정, 그리고 각자의 역할에 대해 멘토님이 친절하게 설명해주실 거예요. 궁금한 점이 있다면 언제든 질문해 주세요!

                        3. 팀 빌딩 액티비티
                           팀워크를 쑥쑥 키울 수 있는 활동이 기다리고 있어요! 함께 협력해서 문제를 해결하고, 팀으로서의 결속력을 다지는 시간이 될 거예요.

                        이번 모임을 통해 우리 팀이 더욱 가까워지고, 프로젝트에 대한 이해도 깊어질 거라 믿어요. 부담 없이 오셔서 함께 즐거운 시간을 보내요!
                        
                        여러분의 많은 참석 부탁드려요. 감사합니다!
                        """,
                        date: Date.now,
                        place: .init(
                            type: .offline,
                            name: "강남역",
                            link: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=강남역"
                        ),
                        todos: [
                            .init(id: 1, content: "즐거운 마음 준비!", status: .pending),
                            .init(id: 2, content: "참여 여부 투표!", status: .pending)
                        ]
                    ),
                    .init(
                        id: 2,
                        title: "5차 세션 : 최종 팀빌딩",
                        body: """
                        안녕하세요, 팀원 여러분!

                        벌써 다섯 번째 세션이라니, 믿기시나요? 이번엔 드디어 최종 팀빌딩 시간이 찾아왔어요! 우리 팀의 결속력을 한층 더 높일 수 있는 신나는 시간!

                        🕒 시간: 2024년 8월 5일 오후 3시
                        📍 장소: 본사 3층 대회의실

                        편하게 오셔서 함께 즐거운 시간 보내요! 기대할게요!

                        - 팀 멘토 드림 😊
                        """,
                        date: Date.now,
                        place: .init(
                            type: .online,
                            name: "ZEP",
                            link: "https://zep.us/en"
                        ),
                        todos: [
                            .init(id: 1, content: "📄 과제 제출", status: .pending),
                            .init(id: 2, content: "✅ 과제 제출 확인 요청", status: .pending)
                        ]
                    )
                ]
            ),
            .init(
                id: 3,
                name: "즐거운 소모임",
                status: .join,
                announcements: []
            ),
            .init(
                id: 4,
                name: "행복한 스터디",
                status: .pending,
                announcements: []
            )
        ]
        
        return .just(mock)
    }
}
