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

public class NofficeList: UIControl {
    // MARK: Event
    public var _onTap: PublishSubject<Void> = PublishSubject()
    public var onTap: Observable<Void> {
        return _onTap.asObservable()
    }
    
    // MARK: Data source
    public var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    public var status: NofficeList.Status = .unselected {
        didSet {
            updateByStatus()
        }
    }
    
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
    public init() {
        super.init(frame: .zero)
        
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
    public func stateToggle() {
        status = status == .selected ? .unselected : .selected
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
            $0.top.bottom.equalToSuperview().inset(Self.verticalPadding)
            $0.leading.trailing.equalToSuperview().inset(Self.horizontalPadding)
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
                
                self.backgroundView.backgroundColor = .green100
                self.label.textColor = .green500
                self.icon.tintColor = .green500
            }
        case .unselected:
            self.icon.isHidden = false
            UIView.transition(
                with: self,
                duration: 0.2,
                options: [.transitionCrossDissolve]
            ) { [weak self] in
                guard let self = self else { return }
                
                self.backgroundView.backgroundColor = .grey100
                self.label.textColor = .grey400
                self.icon.tintColor = .grey400
            }
        }
    }
    
    // MARK: UIControl
    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        _onTap.onNext(())
        sendActions(for: .touchUpInside)
    }
}

// MARK: - Display model
public extension NofficeList {
    enum Status: String, CaseIterable {
        case unselected, selected
    }
}

// MARK: - Constant
private extension NofficeList {
    static let verticalPadding = 12
    static let horizontalPadding = 16
}
