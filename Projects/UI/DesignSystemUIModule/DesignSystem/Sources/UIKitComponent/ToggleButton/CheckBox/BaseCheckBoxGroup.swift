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
    
    public var changeSelectedOptions: Binder<[Option]> {
        return Binder(self) { (checkBoxGroup: BaseCheckBoxGroup, selectedOptions: [Option]) in
            checkBoxGroup.selectedOptions = selectedOptions
        }
    }
    
    // MARK: Data
    private var selectedOptions: [Option] = [] {
        didSet {
            _onChangeSelectedOptions.onNext(selectedOptions)
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
    private let options: [any ToggleButton]
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public override init(frame: CGRect) {
        self.options = []
        super.init(frame: frame)
        setupHierarchy()
        setupBind()
        updateLayout()
    }

    public required init?(coder: NSCoder) {
        self.options = []
        super.init(coder: coder)
        setupHierarchy()
        setupBind()
        updateLayout()
    }

    public init(
        source: [Option],
        itemBuilder: @escaping ViewBuilder
    ) {
        self.options = source.map { itemBuilder($0) }
        
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
        
        for (index, option) in options.enumerated() {
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
        options.forEach { option in
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
    private func updateLayout() {
        verticalStackView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
