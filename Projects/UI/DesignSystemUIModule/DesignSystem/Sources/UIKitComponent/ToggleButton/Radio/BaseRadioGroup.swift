//
//  BaseRadioGroup.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/16/24.
//

import UIKit

import RxSwift
import Then
import SnapKit

public extension BaseRadioGroup {
    func gridStyled(
        columns: Int = 1,
        verticalSpacing: CGFloat = 8,
        horizontalSpacing: CGFloat = 8
    ) {
        self.columns = columns
        self.verticalStackView.spacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing
        setupHierarchy()
        updateLayout()
    }
}

public class BaseRadioGroup<Option>: UIView where Option: Equatable & Identifiable {
    public typealias ViewBuilder = (Option) -> any ToggleButton
    
    // MARK: Event
    private let _onChangeSelectedOption = PublishSubject<Option?>()
    public var onChangeSelectedOption: Observable<Option?> {
        return _onChangeSelectedOption.asObservable()
    }
    
    public var changeSelectedOption: Binder<Option?> {
        return Binder(self) { (radioGroup: BaseRadioGroup, selectedOption: Option?) in
            radioGroup.selectedOption = selectedOption
        }
    }
    
    // MARK: State
    private var selectedOption: Option? {
        didSet {
            _onChangeSelectedOption.onNext(selectedOption)
        }
    }
    
    // MARK: UI Constant
    private var columns: Int = 1
    private var horizontalSpacing: CGFloat = 8
    
    // MARK: UI Component
    private var verticalStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    // MARK: Build component
    private let optionComponents: [any ToggleButton]
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        self.optionComponents = []
        super.init(frame: frame)
        setupHierarchy()
        setupBind()
        updateLayout()
    }

    public required init?(coder: NSCoder) {
        self.optionComponents = []
        super.init(coder: coder)
        setupHierarchy()
        setupBind()
        updateLayout()
    }

    public init(
        source: [Option],
        itemBuilder: @escaping ViewBuilder
    ) {
        self.optionComponents = source.map { itemBuilder($0) }
        
        super.init(frame: .zero)
        
        setupHierarchy()
        setupBind()
        updateLayout()
    }
    
    // MARK: Life cycle
    
    // MARK: Setup
    private func setupHierarchy() {
        // Clear existing views
        verticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        addSubview(verticalStackView)
        
        var horizontalStackView = createHorizontalStackView()
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        for (index, option) in optionComponents.enumerated() {
            if index % columns == 0 && index != 0 {
                horizontalStackView = createHorizontalStackView()
                verticalStackView.addArrangedSubview(horizontalStackView)
            }
            horizontalStackView.addArrangedSubview(option)
        }
    }
    
    private func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = horizontalSpacing
            $0.distribution = .fillEqually
        }
        return stackView
    }
    
    private func setupBind() {
        optionComponents.forEach { option in
            option.onChangeSelected
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] selected in
                    guard let self = self else { return }
                    
                    if let value = option.value as? Option {
                        if selected {
                            self.selectOption(value)
                        } else {
                            self.deselectOption(value)
                        }
                    }
                })
                .disposed(by: disposeBag)
        }
    }

    private func selectOption(_ value: Option) {
        self.selectedOption = value
        self.optionComponents.forEach { toggleButton in
            if let toggleButtonValue = toggleButton.value as? Option,
                toggleButtonValue != value {
                toggleButton.isSelected = false
            }
        }
    }

    private func deselectOption(_ value: Option) {
        if self.selectedOption == value {
            self.selectedOption = nil
        }
    }
    
    // MARK: Update
    private func updateLayout() {
        verticalStackView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
