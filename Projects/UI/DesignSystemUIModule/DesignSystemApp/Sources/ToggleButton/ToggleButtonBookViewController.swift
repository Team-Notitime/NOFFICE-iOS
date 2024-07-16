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
    
    private let toggleButton = ToggleButton<ToggleOption>(
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
        
        stackView.addArrangedSubview(UIView().then {
            $0.backgroundColor = .lightGray
            $0.snp.makeConstraints { $0.height.equalTo(1) }
        })
        
        stackView.addArrangedSubview(toggleButton)
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
        
        toggleButton.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
            $0.height.equalTo(44)
        }
    }

    private func setupBind() {
        Observable.combineLatest(
            colorControl.rx.selectedSegmentIndex,
            shapeControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            owner.toggleButton.styled(
                color: BasicToggleButtonColor.allCases[value.0],
                shape: BasicToggleButtonShape.allCases[value.1]
            )
        })
        .disposed(by: disposeBag)
    }
}
