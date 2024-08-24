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
        // - Stop skeleton
        reactor.state.map { $0.announcement }
            .compactMap { $0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                self?.stopSkeleton()
            })
            .disposed(by: disposeBag)
        
        // - Bind organization name
        reactor.state.map { $0.organization?.name }
            .asDriver(onErrorJustReturn: "")
            .drive(baseView.orgnizationNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        // - Bind organization profile image
        reactor.state.map { $0.organization?.profileImageUrl }
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] profileImageUrl in
                self?.baseView.organizationProfileImage.kf.setImage(
                    with: profileImageUrl
                )
            })
            .disposed(by: disposeBag)
        
        // - Bind annuncement summary
        reactor.state.map { $0.announcementSummary }
            .asDriver(onErrorJustReturn: nil)
            .compactMap { $0 }
            .drive(with: self, onNext: { owner, announcementSummary in
                owner.baseView.titleLabel.text = announcementSummary?.title
                owner.baseView.createdDateLabel.text = announcementSummary?.endAt?
                    .toString(format: "yyyy.MM.dd HH:mm") ?? "-"
            })
            .disposed(by: disposeBag)
        
        
        // - Bind announcement detail
        reactor.state.map { $0.announcement }
            .compactMap { $0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onNext: { owner, item in
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
                        else { return }
                        
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
