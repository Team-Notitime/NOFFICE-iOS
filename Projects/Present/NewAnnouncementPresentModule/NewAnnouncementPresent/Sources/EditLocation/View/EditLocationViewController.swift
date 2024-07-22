//
//  EditLocationViewController.swift
//  NewAnnouncementPresent
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import Router
import DesignSystem

import Swinject
import RxSwift
import RxCocoa
import RxGesture
import Kingfisher

class EditLocationViewController: BaseViewController<EditLocationView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(EditLocationReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() { 
        // - Delete name text field text
        baseView.locationNameDeleteButton
            .rx.tapGesture()
            .map { _ in "" }
            .bind(to: baseView.locationNameTextField.text)
            .disposed(by: disposeBag)
        
        // - Delete link text field text
        baseView.locationLinkDeleteButton
            .rx.tapGesture()
            .map { _ in "" }
            .bind(to: baseView.locationLinkTextField.text)
            .disposed(by: disposeBag)
        
        // - Name delete button visibility
        baseView.locationNameTextField
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .map { !$0.isEmpty }
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, isHidden in
                owner.baseView.locationNameDeleteButton.isHidden = !isHidden
            })
            .disposed(by: disposeBag)
        
        // - Link delete button visibility
        baseView.locationLinkTextField
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .map { !$0.isEmpty }
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, isHidden in
                owner.baseView.locationLinkDeleteButton.isHidden = !isHidden
            })
            .disposed(by: disposeBag)
    }
    
    override func setupStateBind() { 
        // - Open graph card visibility
        reactor.state.map { $0.locationLink }
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .compactMap { URL(string: $0) != nil ? $0 : "" }
            .distinctUntilChanged()
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, link in
                owner.baseView.openGraphCard.isHidden = link.isEmpty
                
                if link.isEmpty {
                    owner.baseView.openGraphImageView.image = nil
                    owner.baseView.openGraphTitleLabel.text = ""
                    owner.baseView.openGraphLinkLabel.text = ""
                }
            })
            .disposed(by: disposeBag)
        
        // - Open graph image
        reactor.state.map { $0.openGraph?.imageURL }
            .compactMap { $0 }
            .compactMap { URL(string: $0) }
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, imageURL in
                owner.baseView.openGraphImageView.kf.indicatorType = .activity
                owner.baseView.openGraphImageView.kf.setImage(
                    with: imageURL,
                    options: [
                        .transition(.fade(0.5)),
                        .forceRefresh
                    ]
                )
            })
            .disposed(by: disposeBag)
        
        // - Open graph title
        reactor.state.map { $0.openGraph?.title }
            .compactMap { $0 }
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, title in
                owner.baseView.openGraphTitleLabel.text = title
            })
            .disposed(by: disposeBag)
        
        // - Open graph url
        reactor.state.map { $0.openGraph?.url }
            .compactMap { $0 }
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, link in
                owner.baseView.openGraphLinkLabel.text = link
            })
            .disposed(by: disposeBag)
    }
    
    override func setupActionBind() { 
        // - Tap back button
        baseView.navigationBar
            .onTapBackButton
            .subscribe(onNext: {
                Router.shared.backToPresented()
            })
            .disposed(by: disposeBag)
        
        // - Edit name text field
        baseView.locationNameTextField
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .map { .changeLocationName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Edit link text field
        baseView.locationLinkTextField
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .debug()
            .map { .changeLocationLink($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
