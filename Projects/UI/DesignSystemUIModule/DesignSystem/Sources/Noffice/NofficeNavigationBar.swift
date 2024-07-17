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

public class NofficeNavigationBar: UIView {
    public typealias ViewBuilder = () -> UIView
    
    // MARK: Event
    private let _onTapRightItem = PublishSubject<Void>()
    private var onTapRightItem: Observable<Void> {
        return _onTapRightItem.asObservable()
    }
    
    private var backButtonAction: (() -> Void) = { }
    
    // MARK: UI Constant
    let height: CGFloat = 44
    
    // MARK: UI Component
    private lazy var backIcon = UIImageView(image: .iconChevronLeft).then {
        $0.tintColor = .grey400
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: Build component
    private var rightItem: UIView = UIView()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public init(
        backButtonAction: @escaping () -> Void,
        rightItem: ViewBuilder = { UIView() }
    ) {
        super.init(frame: .zero)
        
        self.backButtonAction = backButtonAction
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
        addSubview(rightItem)
    }
    
    private func setupLayout() { 
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        
        backIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        rightItem.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupBind() { 
        backIcon.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.backButtonAction()
            })
            .disposed(by: disposeBag)
        
        rightItem.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?._onTapRightItem.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Update
}
