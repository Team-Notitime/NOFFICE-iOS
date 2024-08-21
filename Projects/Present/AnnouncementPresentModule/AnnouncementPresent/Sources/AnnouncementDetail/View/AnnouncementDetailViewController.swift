//
//  AnnouncementDetailViewController.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import UIKit

import DesignSystem
import Assets
import Router
import AnnouncementUsecase
import AnnouncementEntity

import Swinject
import RxSwift
import RxCocoa
import SkeletonView

public class AnnouncementDetailViewController: BaseViewController<AnnouncementDetailView> {
    // MARK: Constant
    private let bodyLabelLineHeight: CGFloat = 1.5
    
    // MARK: DI
    private let reactor = Container.shared.resolve(AnnouncementDetailReactor.self)!
    
    // MARK: Data
    private let announcement: AnnouncementSummaryEntity
    
    // MARK: Initialzier
    public init(announcement: AnnouncementSummaryEntity) {
        self.announcement = announcement
        
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor.action.onNext(.viewDidLoad(self.announcement))
    }
    
    // MARK: Setup
    public override func setupViewBind() { 
        setupSkeleton()
        startSkeleton()
    }
    
    public override func setupStateBind() {
        // - Bind announcement detail
        reactor.state.map { $0.announcement}
            .compactMap { $0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onNext: { owner, item in
                    owner.stopSkeleton()
                    
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
                        else { return }
                        
                        weakOwner.reactor.action.onNext(.toggleTodoStatus(todo))
                    }
                )
            }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: baseView.todoListCollectionView.sectionBinder)
            .disposed(by: disposeBag)
    }
    
    public override func setupActionBind() { 
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
