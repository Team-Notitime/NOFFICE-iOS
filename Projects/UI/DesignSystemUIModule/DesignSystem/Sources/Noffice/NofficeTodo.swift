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

public final class NofficeTodo<Option>: UIControl, ToggleButton where Option: Equatable & Identifiable {
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
    
    public var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    public var status: NofficeTodo.Status = .none {
        didSet {
            updateByStatus()
        }
    }
    
    public override var isSelected: Bool {
        get {
            return status == .done
        }
        set {
            status = newValue ? .done : .none
        }
    }
    
    // MARK: UI Constant
    private let verticalPadding = 12
    
    private let horizontalPadding = 16
    
    // MARK: UI Component
    private lazy var backgroundView = UIView().then {
        $0.layer.cornerRadius = RoundedOffset.medium.same
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [label, icon]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    
    private lazy var label = UILabel().then {
        $0.text = ""
        $0.setTypo(.body2b)
        $0.textColor = .blue500
        $0.numberOfLines = 10
    }
    
    private lazy var icon = UIImageView(image: .iconCheck).then {
        $0.tintColor = .grey300
        $0.setSize(width: 16, height: 16)
    }
    
    // MARK: Initializer
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
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Public
    public func statusToggle() {
        status = status == .none ? .done : .none
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(stackView)
    }
    
    private func setupLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(verticalPadding)
            $0.leading.trailing.equalToSuperview().inset(horizontalPadding)
        }
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateByStatus() {
        switch status {
        case .none:
            UIView.transition(
                with: self,
                duration: 0.2,
                options: [.transitionCrossDissolve]
            ) { [weak self] in
                guard let self = self else { return }
                
                self.icon.alpha = 0.0
                self.backgroundView.backgroundColor = .blue100
                self.label.textColor = .blue500
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
                self.backgroundView.backgroundColor = .grey100
                self.label.textColor = .grey400
            } completion: { [weak self] _ in
                self?.icon.isHidden = false
            }
        }
    }
    
    // MARK: UIControl
    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        statusToggle()
        _onChangeStatus.onNext(status)
        _onChangeSelected.onNext(isSelected)
        sendActions(for: .touchUpInside)
    }
}

// MARK: - Display model
public extension NofficeTodo {
    enum Status: String, CaseIterable {
        case none, done
    }
}
