//
//  ButtonBookView.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/24/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import Then
import SnapKit

final class ButtonBookViewController: UIViewController {
    // MARK: UI Component
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 16
    }
    
    let sizeControlLabel = UILabel().then {
        $0.text = "size"
        $0.setTypo(.body1b)
    }
    
    let sizeControl = UISegmentedControl(
        items: Array(BasicButtonSize.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let variantControlLabel = UILabel().then {
        $0.text = "variant"
        $0.setTypo(.body1b)
    }
    
    let variantControl = UISegmentedControl(
        items: Array(BasicButtonVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }

    let shapeControlLabel = UILabel().then {
        $0.text = "shape"
        $0.setTypo(.body1b)
    }
    
    let shapeControl = UISegmentedControl(
        items: Array(BasicButtonShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let stateControlLabel = UILabel().then {
        $0.text = "state"
        $0.setTypo(.body1b)
    }
    
    let stateControl = UISegmentedControl(
        items: ["enabled", "disabled"]
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    let divider = UIView().then {
        $0.backgroundColor = .grey100
    }
    
    let colorLabels: [UILabel] = BasicButtonColor.allCases.map { color in
        UILabel().then {
            $0.text = color.rawValue
            $0.setTypo(.body3)
            $0.textColor = .grey400
        }
    }
    
    let buttons: [BaseButton] = BasicButtonColor.allCases.map { _ in
        BaseButton(
            itemBuilder: {
                [
                    UILabel().then {
                        $0.text = "Button"
                        $0.setTypo(.body0b)
                    }
                ]
            }
        ).then {
            $0.styled()
        }
    }
    
    // MARK: DisposeBag
    let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Setup methods
    private func setupHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(variantControlLabel)
        stackView.addArrangedSubview(variantControl)
        stackView.addArrangedSubview(sizeControlLabel)
        stackView.addArrangedSubview(sizeControl)
        stackView.addArrangedSubview(shapeControlLabel)
        stackView.addArrangedSubview(shapeControl)
        stackView.addArrangedSubview(stateControlLabel)
        stackView.addArrangedSubview(stateControl)
        stackView.addArrangedSubview(divider)
        
        buttons.enumerated().forEach { index, button in
            stackView.addArrangedSubview(colorLabels[index])
            stackView.addArrangedSubview(button)
        }
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
            $0.left.right.equalToSuperview().inset(pagePadding)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        sizeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        variantControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        shapeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        stateControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(stackView.snp.width)
        }
        
        buttons.forEach { button in
            button.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
    }
    
    func setupBind() {
        Observable.combineLatest(
            variantControl.rx.selectedSegmentIndex,
            sizeControl.rx.selectedSegmentIndex,
            shapeControl.rx.selectedSegmentIndex,
            stateControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            owner.buttons.enumerated().forEach { index, button in
                button.styled(
                    variant: BasicButtonVariant.allCases[value.0],
                    color: BasicButtonColor.allCases[index],
                    size: BasicButtonSize.allCases[value.1],
                    shape: BasicButtonShape.allCases[value.2]
                )
                button.isEnabled = value.3 == 0
            }
        })
        .disposed(by: disposeBag)
    }
}
