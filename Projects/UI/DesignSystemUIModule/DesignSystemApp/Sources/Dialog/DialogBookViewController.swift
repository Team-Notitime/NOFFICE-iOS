//
//  DialogBookViewController.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import RxCocoa
import Then
import SnapKit

final class DialogBookViewController: UIViewController {
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
        $0.text = "variant"
        $0.setTypo(.body1b)
    }
    
    private lazy var variantControl = UISegmentedControl(
        items: Array(BasicDialogVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }

    private lazy var shapeControlLabel = UILabel().then {
        $0.text = "shape"
        $0.setTypo(.body1b)
    }
    
    private lazy var shapeControl = UISegmentedControl(
        items: Array(BasicDialogShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var dialogOpenButton = BaseButton(
        itemBuilder: {
            [
                UILabel().then {
                    $0.text = "open dialog"
                    $0.setTypo(.body1)
                }
            ]
        }
    ).then {
        $0.styled(variant: .translucent, color: .green, size: .small)
    }
    
    // dialog
    private lazy var dialogTextField = BaseTextField(
        suffixBuilder: {
            [
                UILabel().then {
                    $0.text = "0/0"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(variant: .underlined, size: .textLarge)
        $0.placeholder = "Placeholder"
    }
    
    private lazy var dialogGrayButton = BaseButton(
        itemBuilder: {
            [
                UILabel().then {
                    $0.text = "Action"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(
            variant: .fill,
            color: .ghost,
            size: .medium
        )
    }
    
    private lazy var dialogGreenButton = BaseButton(
        itemBuilder: {
            [
                UILabel().then {
                    $0.text = "Close"
                    $0.setTypo(.body1b)
                }
            ]
        }
    ).then {
        $0.styled(
            variant: .fill,
            color: .green,
            size: .medium
        )
    }
    
    private lazy var dialog = BaseDialog(
        contentbuilder: { [weak self] in
            guard let self = self else { return [] }
            
            return [
                UILabel().then {
                    $0.text = "Dialog title"
                    $0.setTypo(.heading3)
                },
                self.dialogTextField,
                self.dialogGrayButton,
                self.dialogGreenButton
            ]
        }
    )
    
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
        
        stackView.addArrangedSubview(BaseSpacer())
        stackView.addArrangedSubview(BaseDivider())
        stackView.addArrangedSubview(BaseSpacer())
        
        stackView.addArrangedSubview(dialogOpenButton)
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
        }
        
        variantControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        shapeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }

    private func setupBind() {
        dialogOpenButton.onTap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.dialog.open()
            })
            .disposed(by: disposeBag)
        
        dialogGreenButton.onTap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.dialog.close()
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            variantControl.rx.selectedSegmentIndex,
            shapeControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            owner.dialog.styled(
                variant: BasicDialogVariant.allCases[value.0],
                shape: BasicDialogShape.allCases[value.1]
            )
        })
        .disposed(by: disposeBag)
    }
}
