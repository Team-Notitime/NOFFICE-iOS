//
//  BaseTextView.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/22/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

public extension BaseTextView {
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

public class BaseTextView: UIView {
    public typealias ViewBuilder = () -> [UIView]
    
    // MARK: Event
    public let textViewEvent = PublishSubject<UIControl.Event>()
    
    private let _onChange = PublishSubject<String?>()
    public var onChange: Observable<String?> {
        return _onChange.asObservable()
    }
    
    public var text: Binder<String?> {
        return Binder(self) { textView, text in
            textView.innerTextView.text = text
            textView._onChange.onNext(text)
            textView.updatePlaceholderVisibility()
        }
    }
    
    public var textView: UITextView {
        return innerTextView
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
            innerTextView.isEditable = !disabled
            updateTheme()
            updateLayout()
        }
    }
    
    public var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
            updatePlaceholderVisibility()
        }
    }
    
    public var minimumHeight: CGFloat? {
        didSet {
            updateTextViewHeight()
        }
    }
    
    public var maximumHeight: CGFloat? {
        didSet {
            updateTextViewHeight()
        }
    }
    
    // MARK: UI Constant
    private static let AdditionalPaddingForAdjustPlaceholder: CGFloat = 4
    
    // MARK: UI Component
    private lazy var titleStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private lazy var descriptionStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private lazy var textViewBackground = UIView()
    
    private lazy var bottomBorder = UIView().then {
        $0.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
    
    private lazy var textViewStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private lazy var innerTextView = UITextView().then {
        $0.textAlignment = .left
        $0.isScrollEnabled = false
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    private let placeholderLabel = UILabel().then {
        $0.textColor = .tertiaryLabel
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
        
        addSubview(textViewBackground)
        
        textViewBackground.addSubview(textViewStack)
        prefixComponents.forEach {
            textViewStack.addArrangedSubview($0)
        }
        textViewStack.addArrangedSubview(innerTextView)
        suffixComponents.forEach {
            textViewStack.addArrangedSubview($0)
        }
        
        innerTextView.addSubview(placeholderLabel)
        
        addSubview(bottomBorder)
        
        addSubview(descriptionStack)
        descriptionComponents.forEach {
            descriptionStack.addArrangedSubview($0)
        }
    }
    
    private func setupBind() {
        innerTextView.rx.didBeginEditing
            .map { UIControl.Event.editingDidBegin }
            .bind(to: textViewEvent)
            .disposed(by: disposeBag)
        
        innerTextView.rx.didChange
            .map { UIControl.Event.editingChanged }
            .bind(to: textViewEvent)
            .disposed(by: disposeBag)
        
        innerTextView.rx.didChange
            .map { [weak self] in self?.innerTextView.text }
            .bind(to: _onChange)
            .disposed(by: disposeBag)
        
        innerTextView.rx.didEndEditing
            .map { UIControl.Event.editingDidEnd }
            .bind(to: textViewEvent)
            .disposed(by: disposeBag)
        
        innerTextView.rx.didChange
            .subscribe(onNext: { [weak self] in
                self?.updatePlaceholderVisibility()
                self?.updateTextViewHeight()
            })
            .disposed(by: disposeBag)
        
        // Update focus / unfocus theme
        innerTextView.rx.didBeginEditing
            .subscribe(onNext: { [weak self] in
                self?.updateTheme()
            })
            .disposed(by: disposeBag)
        
        innerTextView.rx.didEndEditing
            .subscribe(onNext: { [weak self] in
                self?.updateTheme()
            })
            .disposed(by: disposeBag)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.cancelsTouchesInView = false
        innerTextView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: UITextViewDelegate
    public var location: CGPoint = .zero
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: innerTextView)
        self.location = location
        if let position = innerTextView.closestPosition(to: location) {
            innerTextView.selectedTextRange = innerTextView
                .textRange(from: position, to: position)
        }
        innerTextView.becomeFirstResponder()
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
        self.textViewBackground.layer.borderColor = UIColor.clear.cgColor
        
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let self = self else { return }
            // TextView background
            self.textViewBackground.backgroundColor = backgroundColor
            self.textViewBackground.layer.borderColor = borderColor
            self.textViewBackground.layer.borderWidth = borderWidth
            
            // - TextView
            self.innerTextView.textColor = foregroundColor
            self.innerTextView.setTypo(typo)
            self.placeholderLabel.textColor = placeholderColor
            self.placeholderLabel.setTypo(typo)
            
            // - Title stack
            self.titleStack.arrangedSubviews.forEach {
                if let label = $0 as? UILabel {
                    label.textColor = foregroundColor
                } else if let imageView = $0 as? UIImageView {
                    imageView.tintColor = foregroundColor
                }
            }
            
            // - TextView stack
            self.textViewStack.arrangedSubviews.forEach {
                if let label = $0 as? UILabel {
                    label.textColor = foregroundColor.withAlphaComponent(0.6)
                } else if let imageView = $0 as? UIImageView {
                    imageView.tintColor = foregroundColor.withAlphaComponent(0.6)
                }
            }
            
            // - Bottom border
            self.bottomBorder.backgroundColor = colorTheme
                .bottomBorderColor(state: allState).uiColor
            
            // - Description stack
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
        ? textViewBackground.bounds.height / 2 : figureTheme.rounded().max
        
        textViewBackground.clipsToBounds = true
        textViewBackground.layer.cornerRadius = rounded
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
        
        textViewBackground.snp.remakeConstraints {
            $0.top.equalTo(titleStack.snp.bottom)
                .offset(8)
            $0.left.right.equalToSuperview()
        }
        
        textViewStack.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let inset = UIEdgeInsets(
            top: padding.vertical ?? 0,
            left: (padding.horizontal ?? 0) - Self.AdditionalPaddingForAdjustPlaceholder,
            bottom: padding.vertical ?? 0,
            right: (padding.horizontal ?? 0) - Self.AdditionalPaddingForAdjustPlaceholder
        )
        
        textView.textContainerInset = inset
        textView.contentInset = .zero
        
        placeholderLabel.snp.remakeConstraints {
            $0.top.equalToSuperview()
                .inset(padding.vertical ?? 0)
            $0.left.right.equalToSuperview()
                .inset(padding.horizontal ?? 0)
        }
        
        bottomBorder.snp.remakeConstraints {
            $0.height.equalTo(2)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(textViewBackground.snp.bottom)
        }
        
        descriptionStack.snp.remakeConstraints {
            $0.top.equalTo(textViewBackground.snp.bottom)
                .offset(4)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !innerTextView.text.isEmpty
    }
    
    private func updateTextViewHeight() {
        let size = CGSize(width: innerTextView.frame.width, height: .infinity)
        let estimatedSize = innerTextView.sizeThatFits(size)
        
        // Adjust height based on estimated size, minimumHeight, and maximumHeight
        var newHeight = estimatedSize.height
        
        if let minimumHeight = minimumHeight {
            newHeight = max(newHeight, minimumHeight)
        }
        
        if let maximumHeight = maximumHeight {
            newHeight = min(newHeight, maximumHeight)
        }
        
        // Update textView's height constraint
        innerTextView.snp.updateConstraints {
            $0.height.equalTo(newHeight)
        }
        
        // Enable or disable scrolling based on content height and maximumHeight
        if let maximumHeight = maximumHeight {
            innerTextView.isScrollEnabled = estimatedSize.height > maximumHeight
        } else {
            innerTextView.isScrollEnabled = false
        }
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
        
        if innerTextView.isFirstResponder {
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
public extension Reactive where Base: BaseTextView {
    var text: ControlProperty<String?> {
        return base.textView.rx.text
    }
}
