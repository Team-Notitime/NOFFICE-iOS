//
//  NofficeNavigationBar.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture
import SnapKit
import Then

public final class NofficeNavigationBar: UIView {
    public typealias ViewBuilder = () -> UIView
    
    // MARK: Event
    private let _onTapRightItem = PublishSubject<Void>()
    public var onTapRightItem: Observable<Void> {
        return _onTapRightItem.asObservable()
    }
    
    private let _onTapBackButton = PublishSubject<Void>()
    public var onTapBackButton: Observable<Void> {
        return _onTapBackButton.asObservable()
    }
    
    // MARK: State
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: UI Constant
    let height: CGFloat = 44
    
    // MARK: UI Component
    private lazy var backIcon = UIImageView(image: .iconChevronLeft).then {
        $0.tintColor = .grey400
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: Build component
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .grey800
        $0.setTypo(.body1m)
    }
    
    private lazy var rightItem: UIView = UIView()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public init(
        rightItem: ViewBuilder = { UIView() }
    ) {
        super.init(frame: .zero)
        
        self.rightItem = rightItem()
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Public
    
    // MARK: Setup
    private func setupHierarchy() { 
        addSubview(backIcon)
        
        addSubview(titleLabel)
        
        addSubview(rightItem)
    }
    
    private func setupLayout() { 
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        
        backIcon.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        rightItem.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupBind() { 
        backIcon.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?._onTapBackButton.onNext(())
            })
            .disposed(by: disposeBag)
        
        rightItem.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?._onTapRightItem.onNext(())
            })
            .disposed(by: disposeBag)
    }
}
