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

public class NofficeTodo: UIControl {
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
    
    public var status: NofficeTodo.Status = .none {
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
            $0.top.bottom.equalToSuperview().inset(Self.verticalPadding)
            $0.leading.trailing.equalToSuperview().inset(Self.horizontalPadding)
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
        print("dpd..")
        _onTap.onNext(())
        sendActions(for: .touchUpInside)
    }
}

// MARK: - Display model
public extension NofficeTodo {
    enum Status: String, CaseIterable {
        case none, done
    }
}

// MARK: - Constant
private extension NofficeTodo {
    static let verticalPadding = 12
    static let horizontalPadding = 16
}
