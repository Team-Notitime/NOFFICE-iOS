//
//  CalendarBookViewController.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import RxCocoa
import Then
import SnapKit

final class CalendarBookViewController: UIViewController {
    // MARK: UI Component
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private lazy var colorControlLabel = UILabel().then {
        $0.text = "color"
        $0.setTypo(.body1b)
    }
    
    private lazy var colorControl = UISegmentedControl(
        items: Array(BasicCalendarCellColor.allCases.map { $0.rawValue })
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var shapeControlLabel = UILabel().then {
        $0.text = "shape"
        $0.setTypo(.body1b)
    }
    
    private lazy var shapeControl = UISegmentedControl(
        items: Array(BasicCalendarCellShape.allCases.map { $0.rawValue })
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var calendar = BaseCalendar()
    
    private lazy var captionLabel = UILabel().then {
        $0.text = "*캘린더 셀 테마는 바로 적용되지 않고, 월 단위로 이동하는 시점에 업데이트 됩니다."
        $0.setTypo(.body2)
        $0.textColor = .grey400
        $0.numberOfLines = 0
        $0.textAlignment = .center
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
        
        stackView.addArrangedSubview(colorControlLabel)
        stackView.addArrangedSubview(colorControl)
        
        stackView.addArrangedSubview(shapeControlLabel)
        stackView.addArrangedSubview(shapeControl)
        
        stackView.addArrangedSubview(BaseSpacer())
        stackView.addArrangedSubview(BaseDivider())
        stackView.addArrangedSubview(BaseSpacer())
        
        stackView.addArrangedSubview(calendar)
        
        stackView.addArrangedSubview(captionLabel)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        
        colorControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        shapeControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
        
        calendar.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
            $0.height.equalTo(400)
        }
    }
    
    private func setupBind() {
        Observable.combineLatest(
            colorControl.rx.selectedSegmentIndex,
            shapeControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, indexes in
            let (colorIndex, shapeIndex) = indexes
            
            let selectedColor = BasicCalendarCellColor.allCases[colorIndex]
            let selectedShape = BasicCalendarCellShape.allCases[shapeIndex]
            
            owner.calendar.styled(color: selectedColor, shape: selectedShape)
        })
        .disposed(by: disposeBag)

    }
}
