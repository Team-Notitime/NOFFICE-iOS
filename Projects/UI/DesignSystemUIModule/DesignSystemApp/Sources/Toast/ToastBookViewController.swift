//
//  ToastBookViewController.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/21/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import RxCocoa
import Then
import SnapKit

final class ToastBookViewController: UIViewController {
    // MARK: UI Component
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private lazy var variantControlLabel = UILabel().then {
        $0.text = "Variant"
        $0.setTypo(.body1b)
    }
    
    private lazy var variantControl = UISegmentedControl(
        items: BasicToastVariant.allCases.map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var shapeControlLabel = UILabel().then {
        $0.text = "Shape"
        $0.setTypo(.body1b)
    }
    
    private lazy var shapeControl = UISegmentedControl(
        items: BasicToastShape.allCases.map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var alignmentControlLabel = UILabel().then {
        $0.text = "Alignment"
        $0.setTypo(.body1b)
    }
    
    private lazy var alignmentControl = UISegmentedControl(
        items: BasicToastAlignment.allCases.map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var toastMessageTextField = UITextField().then {
        $0.placeholder = "Enter toast message"
        $0.borderStyle = .roundedRect
    }
    
    private lazy var showToastButton = UIButton(type: .system).then {
        $0.setTitle("Show Toast", for: .normal)
    }
    
    // MARK: DisposeBag
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
        
        stackView.addArrangedSubview(variantControlLabel)
        stackView.addArrangedSubview(variantControl)
        stackView.addArrangedSubview(shapeControlLabel)
        stackView.addArrangedSubview(shapeControl)
        stackView.addArrangedSubview(alignmentControlLabel)
        stackView.addArrangedSubview(alignmentControl)
        
        stackView.addArrangedSubview(BaseSpacer())
        stackView.addArrangedSubview(BaseDivider())
        stackView.addArrangedSubview(BaseSpacer())
        
        stackView.addArrangedSubview(toastMessageTextField)
        stackView.addArrangedSubview(showToastButton)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(600)  // Adjust the height as needed
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(20)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        variantControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        shapeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        alignmentControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        toastMessageTextField.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        showToastButton.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }

    private func setupBind() {
        showToastButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let variant = BasicToastVariant
                    .allCases[owner.variantControl.selectedSegmentIndex]
                let shape = BasicToastShape
                    .allCases[owner.shapeControl.selectedSegmentIndex]
                let alignment = BasicToastAlignment
                    .allCases[owner.alignmentControl.selectedSegmentIndex]
                
                let toast = BaseToast()
                toast.show(
                    in: owner.view,
                    message: "Toast",
                    variant: variant,
                    shape: shape,
                    alignment: alignment,
                    duration: 4.0
                )
            })
            .disposed(by: disposeBag)
    }
}
