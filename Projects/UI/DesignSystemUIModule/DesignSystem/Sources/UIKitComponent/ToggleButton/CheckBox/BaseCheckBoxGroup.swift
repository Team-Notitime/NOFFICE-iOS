//
//  BaseCheckBoxGroup.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/16/24.
//

import UIKit

import RxSwift
import Then
import SnapKit

public extension BaseCheckBoxGroup {
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

public class BaseCheckBoxGroup<Option>: UIView where Option: Equatable & Identifiable {
    public typealias ViewBuilder = (Option) -> any ToggleButton
    
    // MARK: Event
    private let _onChangeSelectedOptions = PublishSubject<[Option]>()
    public var onChangeSelectedOptions: Observable<[Option]> {
        return _onChangeSelectedOptions.asObservable()
    }
    
    // MARK: State
    public var selectedOptions: [Option] = [] {
        didSet {
            _onChangeSelectedOptions.onNext(selectedOptions)
            updateOptions()
        }
    }
    
    public var optionViews: [any ToggleButton] {
        return optionComponents
    }
    
    private var animation: Bool = false
    
    private var columns: Int = 1
    
    private var horizontalSpacing: CGFloat = 8
    
    // MARK: UI Component
    private var verticalStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    // MARK: Builder
    private var optionBuilder: ViewBuilder?
    
    // MARK: Build component
    private var optionComponents: [any ToggleButton] = []
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupBind()
        updateLayout()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupBind()
        updateLayout()
    }

    public init(
        source: [Option],
        animation: Bool = false,
        optionBuilder: ViewBuilder
    ) {
        self.animation = animation
        self.optionComponents = source.map { optionBuilder($0) }
        
        super.init(frame: .zero)
        
        setupHierarchy()
        setupBind()
        updateLayout()
    }
    
    /// Used for injecting the source later due to asynchronous processing.
    ///
    /// - See also: ``updateSource(_:)``
    public init(
        animation: Bool = false,
        optionBuilder: @escaping ViewBuilder
    ) {
        super.init(frame: .zero)
        
        self.animation = animation
        self.optionBuilder = optionBuilder
    }
    
    // MARK: Life cycle
    
    // MARK: Setup
    private func setupHierarchy() {
        // Clear existing views
        verticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        addSubview(verticalStackView)
        
        // Initial opacity set to 0
        if animation {
            optionComponents.forEach {
                $0.layer.opacity = 0.0
            }
        }
        
        var horizontalStackView = createHorizontalStackView()
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        for (index, option) in optionComponents.enumerated() {
            if index % columns == 0 && index != 0 {
                horizontalStackView = createHorizontalStackView()
                verticalStackView.addArrangedSubview(horizontalStackView)
            }
            horizontalStackView.addArrangedSubview(option)
            
            // Add opacity animation
            if animation {
                let delay = 0.15 * Double(index)
                UIView.animate(
                    withDuration: 1.0,
                    delay: delay,
                    options: [],
                    animations: {
                        option.layer.opacity = 1.0
                    },
                    completion: nil
                )
            }
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
                    guard let self = self, let value = option.value else { return }
                    
                    guard let value = value as? Option else { return }
                    
                    if selected {
                        self.selectedOptions.append(value)
                    } else {
                        self.selectedOptions.removeAll(where: { $0 == value })
                    }
                })
                .disposed(by: disposeBag)
        }
    }
    
    // MARK: Update
    public func updateSource(_ source: [Option]) {
        guard let optionBuilder = optionBuilder else {
            fatalError("Option builder is not set")
        }
        
        self.optionComponents = source.map { optionBuilder($0) }
        
        setupHierarchy()
        setupBind()
        updateLayout()
    }
    
    private func updateLayout() {
        verticalStackView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateOptions() {
        optionComponents.forEach { option in
            if let value = option.value as? Option {
                option.isSelected = selectedOptions.contains(value) // TODO: 시간복잡도 개선 필요
            }
        }
    }
}
