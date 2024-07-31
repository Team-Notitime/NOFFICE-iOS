//
//  NofficeTodo.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import Assets

import RxSwift
import RxCocoa
import SnapKit
import Then

public final class NofficeTodo<Option>: UIControl, ToggleButton 
where Option: Equatable & Identifiable {
    // MARK: Event
    private let _onChangeSelected: PublishSubject<Bool> = PublishSubject()
    /// Emits a Bool when the isSelected property of the UIControl subclass NofficeTodo changes.
    public var onChangeSelected: Observable<Bool> {
        return _onChangeSelected.asObservable()
    }

    private let _onChangeStatus: PublishSubject<Status> = PublishSubject()
    /// Emits a NofficeTodo.Status event when the status of the NofficeTodo changes.
    public var onChangeStatus: Observable<Status> {
        return _onChangeStatus.asObservable()
    }
    
    // MARK: Data
    public var value: Option?
    
    public var automaticToggle: Bool = true
    
    public var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    public var status: NofficeTodo.Status = .pending {
        didSet {
            updateByStatus()
        }
    }
    
    public override var isSelected: Bool {
        get {
            return status == .done
        }
        set {
            status = newValue ? .done : .pending
        }
    }
    
    // MARK: UI Constant
    private let verticalPadding: CGFloat = 12
    
    private let horizontalPadding: CGFloat = 16
    
    private let checkIconBackgroundSize: CGFloat = 24
    
    private let checkIconSize: CGFloat = 16
    
    // MARK: UI Component
    // - Container view
    private lazy var stackView = UIStackView(
        arrangedSubviews: [iconBackground, label]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.isUserInteractionEnabled = false
    }
    
    // - Todo content text
    private lazy var label = UILabel().then {
        $0.text = ""
        $0.setTypo(.body2b)
        $0.textColor = .blue600
        $0.numberOfLines = 10
    }
    
    // - Check icon
    private lazy var iconBackground = UIView().then {
        $0.backgroundColor = .blue100
        $0.layer.cornerRadius = checkIconBackgroundSize / 2
    }
    
    private lazy var icon = UIImageView(image: .iconCheck).then {
        $0.tintColor = .fullWhite
        $0.setSize(width: checkIconSize, height: checkIconSize)
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: Initializer
    public init() {
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayout()
        setupBind()
        updateByStatus()
    }
    
    public init(option: Option) {
        value = option
        
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayout()
        setupBind()
        updateByStatus()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("")
    }
    
    // MARK: Public
    public func statusToggle() {
        status = status == .pending ? .done : .pending
        
        _onChangeStatus.onNext(status)
        _onChangeSelected.onNext(isSelected)
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(stackView)
        
        iconBackground.addSubview(icon)
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
                .inset(verticalPadding)
            $0.leading.trailing.equalToSuperview()
        }
        
        iconBackground.snp.makeConstraints {
            $0.width.height.equalTo(checkIconBackgroundSize)
        }
        
        icon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateByStatus() {
        switch status {
        case .pending:
            UIView.transition(
                with: self,
                duration: 0.2,
                options: [.transitionCrossDissolve]
            ) { [weak self] in
                guard let self = self else { return }
                
                self.icon.alpha = 0.0
                self.iconBackground.backgroundColor = .blue100
            } completion: { [weak self] _ in
                self?.icon.isHidden = true
            }
        case .done:
            self.icon.isHidden = false
            UIView.transition(
                with: self,
                duration: 0.2,
                options: [.transitionCrossDissolve]
            ) { [weak self] in
                guard let self = self else { return }
                
                self.icon.alpha = 1.0
                self.iconBackground.backgroundColor = .blue600
            } completion: { [weak self] _ in
                self?.icon.isHidden = false
            }
        }
    }
    
    // MARK: UIControl
    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if automaticToggle {
            statusToggle()
        }
        
        sendActions(for: .touchUpInside)
    }
}

// MARK: - Display model
public extension NofficeTodo {
    enum Status: String, CaseIterable {
        case pending, done
    }
}
