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

class EditPlaceViewController: BaseViewController<EditPlaceView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(EditPlaceReactor.self)!
    
    // MARK: Setup
    override func setupViewBind() { 
        // - Delete name text field text
        baseView.placeNameDeleteButton
            .rx.tapGesture()
            .map { _ in "" }
            .bind(to: baseView.placeNameTextField.text)
            .disposed(by: disposeBag)
        
        // - Delete link text field text
        baseView.placeLinkDeleteButton
            .rx.tapGesture()
            .map { _ in "" }
            .bind(to: baseView.placeLinkTextField.text)
            .disposed(by: disposeBag)
        
        // - Name delete button visibility
        baseView.placeNameTextField
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .map { !$0.isEmpty }
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, isHidden in
                owner.baseView.placeNameDeleteButton.isHidden = !isHidden
            })
            .disposed(by: disposeBag)
        
        // - Link delete button visibility
        baseView.placeLinkTextField
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .map { !$0.isEmpty }
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, isHidden in
                owner.baseView.placeLinkDeleteButton.isHidden = !isHidden
            })
            .disposed(by: disposeBag)
    }
    
    override func setupStateBind() {
        // - Bind place type
        reactor.state.map { $0.placeType }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: baseView.placeTypeSegmentControl.selectedOption)
            .disposed(by: disposeBag)
        
        // - Bind place name
        reactor.state.map { $0.placeName }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: baseView.placeNameTextField.text)
            .disposed(by: disposeBag)
        
        // - Bind place link
        reactor.state.map { $0.placeLink }
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: baseView.placeLinkTextField.text)
            .disposed(by: disposeBag)
        
        // - Bind place link error state (url validation)
        reactor.state.map { $0.isURLError }
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { owner, isURLError in
                owner.baseView.placeLinkTextField
                    .state = isURLError ? .error : .normal
                owner.baseView.placeLinkErrorMessage.layer
                    .opacity = isURLError ? 1.0 : 0.0
            }
            .disposed(by: disposeBag)
        
        // - Open graph card visibility
        reactor.state.map { $0.openGraph }
            .map { $0 != nil }
            .distinctUntilChanged()
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .bind { owner, isVisible in
                owner.baseView.openGraphCard.isHidden = !isVisible
            }
            .disposed(by: disposeBag)
        
        // - Open graph image
        reactor.state.map { $0.openGraph?.imageURL }
            .compactMap { $0 }
            .compactMap { URL(string: $0) }
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { owner, imageURL in
                owner.baseView.openGraphImageView.kf.indicatorType = .activity
                owner.baseView.openGraphImageView.kf.setImage(
                    with: imageURL,
                    options: [
                        .transition(.fade(0.5))
                    ]
                )
            })
            .disposed(by: disposeBag)
        
        // - Open graph title
        reactor.state.map { $0.openGraph?.title }
            .compactMap { $0 }
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { owner, title in
                owner.baseView.openGraphTitleLabel.text = title
            })
            .disposed(by: disposeBag)
        
        // - Open graph url
        reactor.state.map { $0.openGraph?.url }
            .compactMap { $0 }
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
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
        
        // - Change place type
        baseView.placeTypeSegmentControl
            .onChange
            .distinctUntilChanged()
            .map { .changePlaceType($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Edit name text field
        baseView.placeNameTextField
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .map { .changePlaceName($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Edit link text field
        baseView.placeLinkTextField
            .onChange
            .distinctUntilChanged()
            .compactMap { $0 }
            .map { .changePlaceLink($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // - Tap save button
        baseView.saveButton
            .onTap
            .subscribe(onNext: {
                Router.shared.backToPresented()
            })
            .disposed(by: disposeBag)
    }
}
