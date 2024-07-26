//
//  TimePickerBookViewController.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/24/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift
import RxCocoa
import Then
import SnapKit

final class TimePickerBookViewController: UIViewController {
    // MARK: UI Component
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private lazy var timePicker = BaseTimePicker()
    
    private lazy var captionLabel = UILabel().then {
        $0.text = "*The theme for the time picker is under preparation."
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
        
        stackView.addArrangedSubview(timePicker)
        
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
        
        timePicker.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }
    
    private func setupBind() { }
}
