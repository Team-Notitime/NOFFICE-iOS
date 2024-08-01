//
//  NofficeList.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/16/24.
//

import UIKit

import Assets

import RxSwift
import RxCocoa
import SnapKit
import Then

public final class NofficeList<Option>: UIControl, ToggleButton where Option: Equatable & Identifiable {
    public typealias ViewBuilder = (Option) -> [UIView]
    
    // MARK: Event
    private let _onChangeSelected: PublishSubject<Bool> = PublishSubject()
    /// Emits a Bool when the isSelected property of the UIControl subclass NofficeList changes.
    public var onChangeSelected: Observable<Bool> {
        return _onChangeSelected.asObservable()
    }

    private let _onChangeStatus: PublishSubject<Status> = PublishSubject()
    /// Emits a NofficeList.Status event when the status of the NofficeList changes.
    public var onChangeStatus: Observable<Status> {
        return _onChangeStatus.asObservable()
    }
    
    // MARK: Data
    public var value: Option?
    
    public var automaticToggle: Bool = true
    
    public var status: Status = .unselected {
        didSet {
            updateByStatus()
            _onChangeStatus.onNext(status)
        }
    }
    
    public override var isSelected: Bool {
        get {
            return status == .selected
        }
        set {
            status = newValue ? .selected : .unselected
        }
    }
    
    // MARK: UI Constant
    private let VerticalPadding = 14
    
    private let HorizontalPadding = 16
    
    // MARK: UI Component
    private lazy var backgroundView = UIView().then {
        $0.layer.cornerRadius = RoundedOffset.medium.same
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
    }
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    // MARK: Build component
    private var contentComponents: [UIView] = []
    
    // MARK: Initializer
    public init(
        option: Option,
        content: ViewBuilder
    ) {
        value = option
        contentComponents = content(option)
        
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayout()
        setupBind()
        updateByStatus()
    }
    
    required init?(coder: NSCoder) {
        value = nil
        
        super.init(coder: coder)
        
        setupHierarchy()
        setupLayout()
        setupBind()
        updateByStatus()
    }
    
    // MARK: Public
    public func statusToggle() {
        status = status == .selected ? .unselected : .selected
        
        _onChangeStatus.onNext(status)
        _onChangeSelected.onNext(isSelected)
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(backgroundView)
        
        backgroundView.addSubview(stackView)
        
        contentComponents.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setupLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
                .inset(VerticalPadding)
            $0.leading.trailing.equalToSuperview()
                .inset(HorizontalPadding)
        }
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateByStatus() {
        switch status {
        case .selected:
            UIView.transition(
                with: self,
                duration: 0.2,
                options: [.transitionCrossDissolve]
            ) { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.backgroundView.backgroundColor = .green100
                    
                    self.stackView.arrangedSubviews.forEach {
                        if let label = $0 as? UILabel {
                            label.textColor = .green700
                        } else if let icon = $0 as? UIImageView {
                            icon.tintColor = .green700
                        }
                    }
                }
            }
        case .unselected:
            UIView.transition(
                with: self,
                duration: 0.2,
                options: [.transitionCrossDissolve]
            ) { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.backgroundView.backgroundColor = .grey100
                    
                    self.stackView.arrangedSubviews.forEach {
                        if let label = $0 as? UILabel {
                            label.textColor = .grey600
                        } else if let icon = $0 as? UIImageView {
                            icon.tintColor = .grey600
                        }
                    }
                }
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
public extension NofficeList {
    enum Status {
        case selected, unselected
    }
}
