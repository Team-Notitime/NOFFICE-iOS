//
//  AnnouncementPageViewController.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/15/24.
//

import UIKit

import Router
import DesignSystem

import RxSwift
import RxCocoa

public class AnnouncementPageViewController: BaseViewController<AnnouncementPageView> {
    
    private let reactor = AnnouncementPageReactor()
    
    private lazy var sectionsSubject = BehaviorSubject<[any CompositionalSection]>(value: sections)
    
    var sections: [any CompositionalSection] = [
        BannerSection(
            identifier: UUID().uuidString,
            items: [
                BannerItem(
                    userName: "이즌",
                    todayPrefixText: "활기찬",
                    dateText: "8월 27일 화요일"
                )
            ]
        ),
        OrganizationSection(
            identifier: UUID().uuidString,
            organizationName: "CMC 15th",
            items: [
                AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP"),
                AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP"),
                AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP"),
                AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP")
            ]
        ),
        OrganizationSection(
            identifier: UUID().uuidString,
            organizationName: "멋진 동아리",
            items: [
                AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP"),
                AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP"),
                AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP"),
                AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP")
            ]
        ),
        OrganizationSection(
            identifier: UUID().uuidString,
            organizationName: "즐거운 소모임",
            items: [
                AnnouncementItem(state: .loading),
                AnnouncementDummyItem()
            ]
        ),
        OrganizationSection(
            identifier: UUID().uuidString,
            organizationName: "행복한 스터디",
            items: [
                AnnouncementItem(state: .none),
                AnnouncementDummyItem()
            ]
        )
    ]
    
    // MARK: Setup
    public override func setupViewBind() {
        baseView.collectionView.bindSections(
            to: sectionsSubject.asObservable()
        )
        .disposed(by: disposeBag)
        
        if let item = sections[1].items[0] as? AnnouncementItem {
            item.onTapAnnouncementCard
                .subscribe(onNext: {
//                    let viewcontroller = UIViewController()
//                    viewcontroller.view.backgroundColor = .fullWhite
//                    Router.shared.push(viewcontroller)
                    
                    print("::: 첫번째 셀 탭탭")
                    
                    let newSection = OrganizationSection(
                        identifier: UUID().uuidString,
                        organizationName: "CMC 15th",
                        items: [
                            AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP"),
                            AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP"),
                            AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP"),
                            AnnouncementItem(state: .default, title: "5차 세션 : 최종 팀빌딩", date: "8월 27일 화요일", location: "ZEP")
                        ]
                    )
                    self.sections.append(newSection)
                    self.sectionsSubject.onNext(self.sections)
                })
                .disposed(by: disposeBag)
        }
    }
    
    // MARK: Converter
    private func convertToCompositionalSection() {
        // TODO:....
    }
}
