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
                        body: "팀 멘토와 친해지길 바라!",
                        date: Date.now,
                        place: .init(
                            type: .offline,
                            name: "강남역",
                            link: "https://naver.com"
                        )
                    ),
                    .init(
                        id: 2,
                        title: "5차 세션 : 최종 팀빌딩",
                        body: "5차 세션 : 최종 팀빌딩",
                        date: Date.now,
                        place: .init(
                            type: .online,
                            name: "ZEP",
                            link: "https://naver.com"
                        )
                    )
                ]
            ),
            .init(
                id: 2,
                name: "멋진 동아리",
                status: .join,
                announcements: [
                    .init(
                        id: 3,
                        title: "1차 모임 공지",
                        body: "팀 멘토와 친해지길 바라!",
                        date: Date.now,
                        place: .init(
                            type: .offline,
                            name: "강남역",
                            link: "https://naver.com"
                        )
                    ),
                    .init(
                        id: 4,
                        title: "5차 세션 : 최종 팀빌딩",
                        body: "5차 세션 : 최종 팀빌딩",
                        date: Date.now,
                        place: .init(
                            type: .online,
                            name: "ZEP",
                            link: "https://naver.com"
                        )
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
