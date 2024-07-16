//
//  ToggleButtonBookViewController.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/16/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import Then
import SnapKit

final class ToogleButtonBookViewController: UIViewController {
    struct ToggleOption: Identifiable, Equatable {
        let id: Int
        let text: String = "Button"
        
        static func factory(_ options: [Int]) -> [ToggleOption] {
            return options.map { ToggleOption(id: $0) }
        }
    }
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let colorControlLabel = UILabel().then {
        $0.text = "Color"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private let colorControl = UISegmentedControl(
        items: BasicToggleButtonColor.allCases.map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private let shapeControlLabel = UILabel().then {
        $0.text = "Shape"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private let shapeControl = UISegmentedControl(
        items: BasicToggleButtonShape.allCases.map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private let toggleButton = BaseToggleButton<ToggleOption>(
        option: ToggleOption(id: 1),
        indicatorVisible: true,
        itemBuilder: { option in
            [
                UILabel().then {
                    $0.text = "\(option.text)"
                    $0.font = UIFont.systemFont(ofSize: 16)
                    $0.textAlignment = .center
                }
            ]
        }
    ).then {
        $0.styled()
    }
    
    private lazy var checkBoxGroupLabel = UILabel().then {
        $0.text = "With CheckBoxGroup"
        $0.setTypo(.body1b)
    }
    
    private lazy var checkBoxGroup = BaseCheckBoxGroup(
        source: ToggleOption.factory(Array(0...3))
    ) { option in
        BaseToggleButton<ToggleOption>(
            option: option,
            indicatorVisible: true,
            itemBuilder: { option in
                [
                    UILabel().then {
                        $0.text = "\(option.text) \(option.id)"
                        $0.font = UIFont.systemFont(ofSize: 16)
                        $0.textAlignment = .center
                    }
                ]
            }
        ).then {
            $0.styled(shape: .circle)
        }
    }
    
    private lazy var checkBoxGroupSelectedOptionsLabel = UILabel().then {
        $0.text = "Selected: "
        $0.setTypo(.body2)
        $0.numberOfLines = 0
    }
    
    private lazy var radioGroupLabel = UILabel().then {
        $0.text = "With RadioGroup (+ grid)"
        $0.setTypo(.body1b)
    }
    
    private lazy var radioGroup = BaseRadioGroup(
        source: ToggleOption.factory(Array(0...3))
    ) { option in
        BaseToggleButton<ToggleOption>(
            option: option,
            indicatorVisible: true,
            itemBuilder: { option in
                [
                    UILabel().then {
                        $0.text = "\(option.text) \(option.id)"
                        $0.font = UIFont.systemFont(ofSize: 16)
                        $0.textAlignment = .center
                    }
                ]
            }
        ).then {
            $0.styled(shape: .circle)
        }
    }.then {
        $0.gridStyled(columns: 2, verticalSpacing: 16, horizontalSpacing: 16)
    }
    
    private lazy var radioGroupSelectedOptionLabel = UILabel().then {
        $0.text = "Selected: "
        $0.setTypo(.body2)
        $0.numberOfLines = 0
    }
    
    private let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Setup methods
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(colorControlLabel)
        stackView.addArrangedSubview(colorControl)
        stackView.addArrangedSubview(shapeControlLabel)
        stackView.addArrangedSubview(shapeControl)
        
        stackView.addArrangedSubview(BaseDivider())
        
        stackView.addArrangedSubview(toggleButton)
        
        stackView.addArrangedSubview(checkBoxGroupLabel)
        stackView.addArrangedSubview(checkBoxGroup)
        stackView.addArrangedSubview(checkBoxGroupSelectedOptionsLabel)
        
        stackView.addArrangedSubview(BaseSpacer(size: 16))
        
        stackView.addArrangedSubview(radioGroupLabel)
        stackView.addArrangedSubview(radioGroup)
        stackView.addArrangedSubview(radioGroupSelectedOptionLabel)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(1000)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        colorControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        shapeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }
    
    private func setupBind() {
        Observable.combineLatest(
            colorControl.rx.selectedSegmentIndex.asObservable(),
            shapeControl.rx.selectedSegmentIndex.asObservable()
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            let color = BasicToggleButtonColor.allCases[value.0]
            let shape = BasicToggleButtonShape.allCases[value.1]
            
            owner.toggleButton.styled(
                color: color,
                shape: shape
            )
        })
        .disposed(by: disposeBag)
        
        // checkbox group
        checkBoxGroup.onChangeSelectedOptions
            .withUnretained(self)
            .subscribe(onNext: { owner, selectedOptions in
                owner.checkBoxGroupSelectedOptionsLabel.text = """
                    Selected: \(selectedOptions.map { "\($0.text) \($0.id)" }.joined(separator: ", "))
                    """
            })
            .disposed(by: disposeBag)
        
        // radio group
        radioGroup.onChangeSelectedOption
            .withUnretained(self)
            .subscribe(onNext: { owner, selectedOption in
                if let selectedOption = selectedOption {
                    owner.radioGroupSelectedOptionLabel.text = "Selected: \(selectedOption.text) \(selectedOption.id)"
                } else {
                    owner.radioGroupSelectedOptionLabel.text = "Selected: "
                }
            })
            .disposed(by: disposeBag)
    }
}
