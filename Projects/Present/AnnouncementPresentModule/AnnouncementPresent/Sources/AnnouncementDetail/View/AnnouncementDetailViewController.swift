//
//  AnnouncementDetailViewController.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import AnnouncementEntity
import AnnouncementUsecase
import Assets
import DesignSystem
import Router
import RxCocoa
import RxSwift
import SkeletonView
import Swinject
import UIKit

public class AnnouncementDetailViewController: BaseViewController<AnnouncementDetailView> {
    // MARK: Constant
    private let bodyLabelLineHeight: CGFloat = 1.5
    
    // MARK: DI
    private let reactor = Container.shared.resolve(AnnouncementDetailReactor.self)!
    
    // MARK: Data
    private let announcement: AnnouncementSummaryEntity
    private let organization: AnnouncementOrganizationEntity
    
    // MARK: Initialzier
    public init(
        announcement: AnnouncementSummaryEntity,
        organization: AnnouncementOrganizationEntity
    ) {
        self.announcement = announcement
        self.organization = organization
        
        super.init()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reactor.action
            .onNext(.viewWillAppear(announcement, organization))
    }
    
    // MARK: Setup
    override public func setupViewBind() {
        setupSkeleton()
        startSkeleton()
    }
    
    override public func setupStateBind() {
        // - Bind organization
        reactor.state.map { $0.organization }
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .debug(":::")
            .subscribe(
                with: self,
                onNext: { owner, organization in
                    owner.stopSkeleton() // TODO: 왜 announcement subscribe쪽에 넣으면 안되는거지? 수정 필요 이건 동기고 announcement가 비동기임
                    
                    owner.baseView.orgnizationNameLabel.text = organization.name
                    owner.baseView.organizationCategoryLabel.text = "" // TODO: 카테고리 방식 바꿔야함
                }
            )
            .disposed(by: disposeBag)
        
        // - Bind announcement detail
        reactor.state.map { $0.announcement }
            .compactMap { $0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onNext: { owner, item in
                    owner.baseView.titleLabel.text = item.title
                    owner.baseView.createdDateLabel.text = item.endAt?
                        .toString(format: "yyyy.MM.dd HH:mm") ?? "-"
                    owner.baseView.eventDateLabel.text = item.endAt?
                        .toString(format: "yyyy.MM.dd(E) HH:mm") ?? "-"
                    owner.baseView.eventPlaceLabel.text = item.place?.name ?? "-"
                    owner.baseView.eventBodyLabel.text = item.body
                    owner.baseView.eventBodyLabel.setLineHeight(
                        multiplier: owner.bodyLabelLineHeight
                    )
                }
            )
            .disposed(by: disposeBag)
        
        // Bind todo item
        reactor.state.map { $0.todoItems }
            .compactMap { $0 }
            .map { Array($0) }
            .withUnretained(self)
            .map { owner, todos in
                AnnouncementDetailConverter.convertToTodoSections(
                    todos: todos,
                    onTapTodoItem: { [weak owner] todo in
                        guard let weakOwner = owner
                        else {
                            return
                        }
                        
                        weakOwner.reactor.action.onNext(.toggleTodoStatus(todo))
                    }
                )
            }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: baseView.todoListCollectionView.sectionBinder)
            .disposed(by: disposeBag)
    }
    
    override public func setupActionBind() {
        // - Bind navigation bar
        baseView.navigationBar
            .onTapBackButton
            .subscribe(onNext: {
                Router.shared.back()
            })
            .disposed(by: disposeBag)
        
        // - Tap event place card
        baseView.eventPlaceCard
            .rx.tapGesture()
            .when(.recognized)
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    if let placeURLString = owner.reactor.currentState.announcement?.place?.link,
                       let placeURL = URL(string: placeURLString) {
                        Router.shared.presentWebView(placeURL)
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    // MARK: Private
    private func setupSkeleton() {
        // Set up isSkeletonable
        baseView.setSkeletonableForViews(
            [
                baseView.titleLabel,
                baseView.createdDateLabel,
                baseView.organizationProfileImage,
                baseView.orgnizationNameLabel,
                baseView.organizationCategoryLabel,
                baseView.eventDateLabel,
                baseView.eventPlaceLabel,
                baseView.eventBodyLabel
            ],
            rootView: baseView.stackView
        )
        
        // Set up skeleton style
        baseView.titleLabel.skeletonTextLineHeight = .relativeToFont
        baseView.titleLabel.linesCornerRadius = SkeletonConstant.LineCornerRadius
        
        baseView.createdDateLabel.skeletonTextLineHeight = .relativeToFont
        baseView.createdDateLabel.linesCornerRadius = SkeletonConstant.LineCornerRadius
        
        baseView.eventDateLabel.skeletonTextNumberOfLines = 1
        baseView.eventDateLabel.skeletonTextLineHeight = .relativeToFont
        baseView.eventDateLabel.linesCornerRadius = SkeletonConstant.LineCornerRadius
        
        baseView.eventPlaceLabel.skeletonTextNumberOfLines = 1
        baseView.eventPlaceLabel.skeletonTextLineHeight = .relativeToFont
        baseView.eventPlaceLabel.linesCornerRadius = SkeletonConstant.LineCornerRadius
        
        baseView.eventBodyLabel.skeletonTextNumberOfLines = 3
        baseView.eventBodyLabel.skeletonTextLineHeight = .relativeToFont
        baseView.eventBodyLabel.linesCornerRadius = SkeletonConstant.LineCornerRadius
    }
    
    private func startSkeleton() {
        let gradient = SkeletonGradient(baseColor: .grey50)
        
        baseView.stackView.showAnimatedGradientSkeleton(
            usingGradient: gradient,
            transition: .crossDissolve(0.25)
        )
    }
    
    private func stopSkeleton() {
        baseView.stackView.hideSkeleton(transition: .crossDissolve(0.25))
    }
}
