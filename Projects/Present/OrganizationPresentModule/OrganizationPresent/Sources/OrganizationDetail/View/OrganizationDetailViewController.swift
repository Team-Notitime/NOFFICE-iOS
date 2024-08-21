//
//  OrganizationDetailViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/31/24.
//

import UIKit

import Router
import DesignSystem
import OrganizationEntity

import RxSwift
import RxCocoa
import Swinject

class OrganizationDetailViewController: BaseViewController<OrganizationDetailView> {
    // MARK: Constant
    private static let AnnouncementSkeletonItemCount = 2
    
    // MARK: Reactor
    private let reactor = Container.shared.resolve(OrganizationDetailReactor.self)!
    
    // MARK: Data
    private let organization: OrganizationEntity
    
    // MARK: Initialzier
    public init(organization: OrganizationEntity) {
        self.organization = organization
        
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        reactor.action.onNext(.viewDidLoad(organization))
    }
    
    // MARK: Setup
    override func setupViewBind() { 
        // TODO: 바인딩 필요
        // - Perform JoinWaitlistButton appearance animation
//        DispatchQueue.main.async {
//            self.animateJoinWaitlistButton()
//        }
        
        // - Add collection view skeleton        
        Observable.just(
            [
                AnnouncementSection(
                    items: (0..<Self.AnnouncementSkeletonItemCount)
                        .map { _ in AnnouncementSkeletonItem() }
                )
            ]
        )
        .bind(to: baseView.announcementsCollectionView.sectionBinder)
        .disposed(by: disposeBag)
    }
    
    override func setupStateBind() { 
        // - Bind organization name
        reactor.state.map { $0.organization?.name }
            .asDriver(onErrorJustReturn: "")
            .drive(baseView.organizationNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        // - Bind leader count
        reactor.state.map { $0.organization?.leader }
            .compactMap { $0 }
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: "")
            .drive(baseView.leaderCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        // - Bind member count
        reactor.state.map { $0.organization?.member }
            .compactMap { $0 }
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: "")
            .drive(baseView.memberCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        // - Bind announcement list
        reactor.state.map { $0.announcements }
//            .filter { !$0.isEmpty }
            .map {
                OrganizationDetailConverter.convert(from: $0) { _ in
//                    Router.shared.push(
//                        .announcementDetail(
//                            announcementEntity: announcement
//                        )
//                    )
                }
            }
            .bind(to: baseView.announcementsCollectionView.sectionBinder)
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() { 
        // - Tap navgation bar back button
        baseView.navigationBar
            .onTapBackButton
            .subscribe(onNext: { _ in
                Router.shared.back()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Private
    /// Button appearance animation with scaling effect
    private func animateJoinWaitlistButton() {
        // Initial state
        baseView.joinWaitlistButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        baseView.joinWaitlistButton.alpha = 0.0
        
        // Animation
        UIView.animate(
            withDuration: 0.7,
            delay: 1,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.8,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                guard let self = self else { return }
                
                baseView.joinWaitlistButton.isHidden = false
                self.baseView.joinWaitlistButton.transform = CGAffineTransform.identity
                self.baseView.joinWaitlistButton.alpha = 1.0
            }, completion: nil
        )
    }
}
