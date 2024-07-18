//
//  BaseTextField.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/24/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

/// Extension for set theme
public extension BaseTextField {
    func styled(
        variant: BasicTextFieldVariant = .plain,
        color: BasicTextFieldColor = .gray,
        size: BasicTextFieldSize = .large,
        shape: BasicTextFieldShape = .round,
        state: TextFieldState = .normal
    ) {
        let colorTheme = BasicTextFieldColorTheme(
            variant: variant,
            color: color
        )
        
        let figureTheme = BasicTextFieldFigureTheme(
            variant: variant,
            size: size,
            shape: shape
        )
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
        self.state = state
    }
}

public class BaseTextField: UIView {
    public typealias ViewBuilder = () -> [UIView]
    
    // MARK: Event
    public let textFieldEvent = PublishSubject<UIControl.Event>()
    
    private let _onChange = PublishSubject<String?>()
    public var onChange: Observable<String?> {
        return _onChange.asObservable()
    }
    
    public var text: Binder<String?> {
        return Binder(self) { textField, text in
            textField.innerTextField.text = text
            textField._onChange.onNext(text) 
        }
    }
    
    public var textField: UITextField {
        return innerTextField
    }
    
    // MARK: Theme
    private var colorTheme: TextFieldColorTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    private var figureTheme: TextFieldFigureTheme? {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    private var state: TextFieldState = .normal {
        didSet {
            updateTheme()
            updateLayout()
        }
    }
    
    public var disabled: Bool = false {
        didSet {
            innerTextField.isEnabled = !disabled
            updateTheme()
            updateLayout()
        }
    }
    
    public var placeholder: String? {
        didSet {
            innerTextField.placeholder = placeholder
        }
    }
    
    // MARK: UI Component
    private let titleStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let descriptionStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let textFieldBackground = UIView()
    
    private let bottomBorder = UIView().then {
        $0.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
    
    private let textFieldStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let innerTextField = UITextField().then {
        $0.textAlignment = .left
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    // MARK: Build component
    private var titleComponents: [UIView] = []
    
    private var prefixComponents: [UIView] = []
    
    private var suffixComponents: [UIView] = []
    
    private var descriptionComponents: [UIView] = []
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
    }
    
    // MARK: Life cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    public init(
        titleBuilder: ViewBuilder = { [] },
        prefixBuilder: ViewBuilder = { [] },
        suffixBuilder: ViewBuilder = { [] },
        descriptionBuilder: ViewBuilder = { [] }
    ) {
        super.init(frame: .zero)
        
        titleComponents.append(contentsOf: titleBuilder())
        prefixComponents.append(contentsOf: prefixBuilder())
        suffixComponents.append(contentsOf: suffixBuilder())
        descriptionComponents.append(contentsOf: descriptionBuilder())
        
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(titleStack)
        titleComponents.forEach {
            titleStack.addArrangedSubview($0)
        }
        
        addSubview(textFieldBackground)
        
        textFieldBackground.addSubview(textFieldStack)
        prefixComponents.forEach {
            textFieldStack.addArrangedSubview($0)
        }
        textFieldStack.addArrangedSubview(innerTextField)
        suffixComponents.forEach {
            textFieldStack.addArrangedSubview($0)
        }
        
        addSubview(bottomBorder)
        
        addSubview(descriptionStack)
        descriptionComponents.forEach {
            descriptionStack.addArrangedSubview($0)
        }
    }
    
    private func setupBind() {
        // Binding textfield event
        innerTextField.rx.controlEvent(.editingDidBegin)
            .map { UIControl.Event.editingDidBegin }
            .bind(to: textFieldEvent)
            .disposed(by: disposeBag)
        
        innerTextField.rx.controlEvent(.editingChanged)
            .map { UIControl.Event.editingChanged }
            .bind(to: textFieldEvent)
            .disposed(by: disposeBag)
        
        innerTextField.rx.controlEvent(.editingChanged)
            .map { [weak self] in self?.innerTextField.text }
            .bind(to: _onChange)
            .disposed(by: disposeBag)
        
        innerTextField.rx.controlEvent(.editingDidEnd)
            .map { UIControl.Event.editingDidEnd }
            .bind(to: textFieldEvent)
            .disposed(by: disposeBag)
        
        innerTextField.rx.controlEvent(.editingDidEndOnExit)
            .map { UIControl.Event.editingDidEndOnExit }
            .bind(to: textFieldEvent)
            .disposed(by: disposeBag)
        
        // Update focus / unfocus theme
        innerTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                self?.updateTheme()
            })
            .disposed(by: disposeBag)
        
        innerTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                self?.updateTheme()
            })
            .disposed(by: disposeBag)
        
        // Set padding as the touch target
        let textFieldPaddingTapGesture = UITapGestureRecognizer()
        textFieldBackground.addGestureRecognizer(textFieldPaddingTapGesture)
        
        textFieldPaddingTapGesture.rx.event
            .bind { [weak self] _ in
                self?.innerTextField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: Update
    func updateTheme() {
        guard let colorTheme = colorTheme, let figureTheme = figureTheme
        else { return }
        
        // color
        let foregroundColor = colorTheme.foregroundColor(state: allState).uiColor
        let placeholderColor = colorTheme.placeholderColor(state: allState).uiColor
        let backgroundColor = colorTheme.backgroundColor(state: allState).uiColor
        let borderColor = colorTheme.borderColor(state: allState).cgColor
        let descriptionColor = colorTheme.descriptionColor(state: allState).uiColor
        
        // figure
        let borderWidth = figureTheme.borderWidth()
        let typo = figureTheme.typo()
        
        updateCornerRadius()
        
        // Default set for animation
        self.textFieldBackground.layer.borderColor = UIColor.clear.cgColor
        
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let self = self else { return }
            // TextField background
            self.textFieldBackground.backgroundColor = backgroundColor
            self.textFieldBackground.layer.borderColor = borderColor
            self.textFieldBackground.layer.borderWidth = borderWidth
            
            // TextField
            self.innerTextField.textColor = foregroundColor
            self.innerTextField.setTypo(typo)
            self.innerTextField.attributedPlaceholder = NSAttributedString(
                string: placeholder ?? "",
                attributes: [.foregroundColor: placeholderColor]
            )
            
            // Title stack
            self.titleStack.arrangedSubviews.forEach {
                if let label = $0 as? UILabel {
                    label.textColor = foregroundColor
                } else if let imageView = $0 as? UIImageView {
                    imageView.tintColor = foregroundColor
                }
            }
            
            // TextField stack
            self.textFieldStack.arrangedSubviews.forEach {
                if let label = $0 as? UILabel {
                    label.textColor = foregroundColor.withAlphaComponent(0.6)
                } else if let imageView = $0 as? UIImageView {
                    imageView.tintColor = foregroundColor.withAlphaComponent(0.6)
                }
            }
            
            // Bottom border
            self.bottomBorder.backgroundColor = colorTheme
                .bottomBorderColor(state: allState).uiColor
            
            // descriptionStack
            self.descriptionStack.arrangedSubviews.forEach {
                if let label = $0 as? UILabel {
                    label.textColor = descriptionColor
                } else if let imageView = $0 as? UIImageView {
                    imageView.tintColor = descriptionColor
                }
            }
        }
    }
    
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme
        else { return }
        
        let rounded = figureTheme.rounded().max == .infinity
        ? textFieldBackground.bounds.height / 2 : figureTheme.rounded().max
        
        textFieldBackground.clipsToBounds = true
        textFieldBackground.layer.cornerRadius = rounded
    }
    
    private func updateLayout() {
        guard let figureTheme = figureTheme
        else { return }
        
        if superview != nil {
            self.snp.remakeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        let padding = figureTheme.padding()
        
        titleStack.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        textFieldBackground.snp.remakeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
        }
        
        textFieldStack.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(padding.vertical ?? 0)
            $0.left.right.equalToSuperview().inset(padding.horizontal ?? 0)
        }
        
        bottomBorder.snp.remakeConstraints {
            $0.height.equalTo(2)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(textFieldBackground.snp.bottom)
        }
        
        descriptionStack.snp.remakeConstraints {
            $0.top.equalTo(textFieldBackground.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Delegate
    private func focusTextField() {
        innerTextField.becomeFirstResponder()
    }
    
    // MARK: Inner token
    private var allState: TextFieldAllState {
        if state == .error {
            return .error
        }
        
        if state == .success {
            return .success
        }
        
        if disabled {
            return .disabled
        }
        
        if innerTextField.isEditing {
            return .focused
        } else {
            return .normal
        }
    }
    
    private var isFullWidth: Bool {
        figureTheme?.frame().width == .infinity
    }
}

// MARK: - Rx extension
public extension Reactive where Base: BaseTextField {
    var text: ControlProperty<String?> {
        return base.textField.rx.text
    }
}
