//
//  BaseCheckBox.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/16/24.
//

import UIKit

import Assets

import RxSwift
import Then
import SnapKit

/// Extension for set theme
public extension BaseToggleButton {
    func styled(
        color: BasicToggleButtonColor = .green,
        shape: BasicToggleButtonShape = .round
    ) {
        let colorTheme = BasicToggleButtonColorTheme(color: color)
        let figureTheme = BasicToggleButtonFigureTheme(shape: shape)
        
        self.colorTheme = colorTheme
        self.figureTheme = figureTheme
    }
}

public class BaseToggleButton<Option>: UIControl where Option: Equatable & Identifiable {
    public typealias ViewBuilder = (Option) -> [UIView]
    
    // MARK: Data
    public let value: Option?
    
    // MARK: Event
    private let _onChange: PublishSubject<Bool> = PublishSubject()
    public var onChange: Observable<Bool> {
        return _onChange.asObservable()
    }
    
    public override var isSelected: Bool {
        didSet {
            updateTheme()
        }
    }
    
    // MARK: Theme
    private var colorTheme: BasicToggleButtonColorTheme? {
        didSet {
            updateTheme()
            updateLayout()
            updateCornerRadius()
        }
    }
    
    private var figureTheme: BasicToggleButtonFigureTheme? {
        didSet {
            updateTheme()
            updateLayout()
            updateCornerRadius()
        }
    }
    
    // MARK: UI Constant
    
    // MARK: UI Component
    private var backgroundView = UIView().then {
        $0.isUserInteractionEnabled = false
    }
    
    private var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
    }
    
    private var indicatorBackground = UIView()
    
    private var indicatorIcon = UIImageView(image: .iconCheck).then {
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: Build component
    public var items: [UIView] = []
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        value = nil
        super.init(frame: frame)
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    public required init?(coder: NSCoder) {
        value = nil
        super.init(coder: coder)
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    public init(
        option: Option,
        indicatorVisible: Bool = true,
        itemBuilder: ViewBuilder
    ) {
        value = option
        
        super.init(frame: .zero)
        
        // add item
        itemBuilder(option).forEach {
            items.append($0)
        }
        
        // indicator setting
        indicatorIcon.isHidden = !indicatorVisible
        
        setupHierarchy()
        setupBind()
        updateTheme()
        updateLayout()
        updateCornerRadius()
    }
    
    // MARK: Life cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        indicatorBackground.layoutIfNeeded()
        updateCornerRadius()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(stackView)
        stackView.addArrangedSubview(indicatorBackground)
        indicatorBackground.addSubview(indicatorIcon)
        
        items.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateCornerRadius() {
        guard let figureTheme = figureTheme else { return }
        
        // indicator
        let rounded = figureTheme.rounded().max == .infinity
        ? indicatorBackground.frame.height / 2 : figureTheme.rounded().max
        
        indicatorBackground.layer.cornerRadius = rounded
        indicatorBackground.clipsToBounds = true
    }
    
    private func updateTheme() {
        guard let colorTheme = colorTheme else { return }
        guard let figureTheme = figureTheme else { return }
        
        let indicatorBackgroundColor = colorTheme.indicatorBackgroundColor(
            state: isSelected ? .checked : .unchecked
        ).uiColor
        let indicatorForegroundColor = colorTheme.indicatorForegroundColor(
            state: isSelected ? .checked : .unchecked
        ).uiColor
        let indicatorBorderColor = colorTheme.indicatorBorderColor(
            state: isSelected ? .checked : .unchecked
        ).cgColor
        
        let labelForegorundColor = colorTheme.labelForegroundColor(
            state: isSelected ? .checked : .unchecked
        ).uiColor
        let labelTypo = figureTheme.labelTypo()
        
        indicatorBackground.backgroundColor = indicatorBackgroundColor
        indicatorBackground.layer.borderColor = indicatorBorderColor
        indicatorBackground.layer.borderWidth = 1
        indicatorIcon.tintColor = indicatorForegroundColor
        
        stackView.arrangedSubviews
            .compactMap { $0 as? UILabel }
            .forEach {
                $0.textColor = labelForegorundColor
                $0.setTypo(labelTypo)
                $0.textAlignment = .left
            }
    }
    
    private func updateLayout() {
        guard let figureTheme = figureTheme else { return }
        
        let innerImageSize = figureTheme.innnerImageSize()
        let padding = figureTheme.padding()
        
        backgroundView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        indicatorIcon.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(padding.same ?? 0)
            $0.height.equalTo(innerImageSize.height ?? 0)
            $0.width.equalTo(innerImageSize.width ?? 0)
        }
        
        stackView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: UIControl
    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        isSelected.toggle()
        _onChange.onNext(isSelected)
        sendActions(for: .touchUpInside)
    }
}
