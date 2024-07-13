//
//  SegmentControlBookViewController.swift
//  DesignSystemBookApp
//
//  Created by DOYEON LEE on 6/26/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import Then
import SnapKit

final class SegmentControlBookViewController: UIViewController {
    struct SegmentOption: Identifiable, Equatable {
        let id: Int
        
        static func factory(_ options: [Int]) -> [SegmentOption] {
            return options.map { SegmentOption(id: $0) }
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
    
    private let variantControlLabel = UILabel().then {
        $0.text = "variant"
        $0.setTypo(.body1b)
    }
    
    private let variantControl = UISegmentedControl(
        items: Array(BasicSegmentVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private let colorControlLabel = UILabel().then {
        $0.text = "color"
        $0.setTypo(.body1b)
    }
    
    private let colorControl = UISegmentedControl(
        items: Array(BasicSegmentColor.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }

    private let shapeControlLabel = UILabel().then {
        $0.text = "shape"
        $0.setTypo(.body1b)
    }
    
    private let shapeControl = UISegmentedControl(
        items: Array(BasicSegmentShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private let segmentControl = BaseSegmentControl(
        source: SegmentOption.factory(Array(0...3)),
        itemBuilder: { option in
            [
                UILabel().then {
                    $0.text = "\(option.id)"
                    $0.setTypo(.body1b)
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
        
        stackView.addArrangedSubview(variantControlLabel)
        stackView.addArrangedSubview(variantControl)
        stackView.addArrangedSubview(colorControlLabel)
        stackView.addArrangedSubview(colorControl)
        stackView.addArrangedSubview(shapeControlLabel)
        stackView.addArrangedSubview(shapeControl)
        
        stackView.addArrangedSubview(BaseSpacer())
        stackView.addArrangedSubview(BaseDivider())
        stackView.addArrangedSubview(BaseSpacer())
        
        stackView.addArrangedSubview(segmentControl)
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
        
        colorControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        shapeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        segmentControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }

    private func setupBind() {
        Observable.combineLatest(
            variantControl.rx.selectedSegmentIndex,
            colorControl.rx.selectedSegmentIndex,
            shapeControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            owner.segmentControl.styled(
                variant: BasicSegmentVariant.allCases[value.0],
                color: BasicSegmentColor.allCases[value.1],
                shape: BasicSegmentShape.allCases[value.2]
            )
        })
        .disposed(by: disposeBag)
    }
}
