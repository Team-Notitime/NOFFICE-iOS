//
//  AnnouncementDetailViewController.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 7/26/24.
//

import UIKit

import DesignSystem
import Assets

import Swinject
import RxSwift
import RxCocoa
import SkeletonView

public class AnnouncementDetailViewController: BaseViewController<AnnouncementDetailView> {
    // MARK: Constant
    private let bodyLabelLineHeight: CGFloat = 1.5
    
    // MARK: DI
    private let reactor = Container.shared.resolve(AnnouncementDetailReactor.self)!
    
    // MARK: Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.reactor.action.onNext(.viewDidLoad)
        }
    }
    
    // MARK: Setup
    public override func setupViewBind() { 
        setupSkeleton()
        startSkeleton()
    }
    
    public override func setupStateBind() {
        // - Bind announcement detail
        reactor.state.map { $0.announcementItem }
            .compactMap { $0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onNext: { owner, item in
                    owner.stopSkeleton()
                    
                    owner.baseView.titleLabel.text = item.title
                    owner.baseView.createdDateLabel.text = item.date?
                        .toString(format: "yyyy.MM.dd HH:mm") ?? "-"
                    owner.baseView.eventDateLabel.text = item.date?
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
        
        reactor.state.map { $0.announcementItem }
            .compactMap { $0 }
            .map { $0.todos ?? [] }
            .subscribe(with: self, onNext: { owner, todos in
                owner.baseView.todoListCollectionView.snp.updateConstraints {
                    $0.height.equalTo(todos.count * 50)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    public override func setupActionBind() { 
        
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
        baseView.titleLabel.linesCornerRadius = SkeletonConstant.lineCornerRadius
        
        baseView.createdDateLabel.skeletonTextLineHeight = .relativeToFont
        baseView.createdDateLabel.skeletonCornerRadius = 12
        baseView.createdDateLabel.skeletonCornerRadius = 12
        baseView.createdDateLabel.linesCornerRadius = SkeletonConstant.lineCornerRadius

        baseView.eventDateLabel.skeletonTextNumberOfLines = 1
        baseView.eventDateLabel.skeletonTextLineHeight = .relativeToFont
        baseView.eventDateLabel.linesCornerRadius = SkeletonConstant.lineCornerRadius

        baseView.eventPlaceLabel.skeletonTextNumberOfLines = 1
        baseView.eventPlaceLabel.skeletonTextLineHeight = .relativeToFont
        baseView.eventPlaceLabel.linesCornerRadius = SkeletonConstant.lineCornerRadius
        
        baseView.eventBodyLabel.skeletonTextNumberOfLines = 3
        baseView.eventBodyLabel.skeletonTextLineHeight = .relativeToFont
        baseView.eventBodyLabel.linesCornerRadius = SkeletonConstant.lineCornerRadius
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
