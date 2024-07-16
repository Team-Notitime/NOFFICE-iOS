//
//  NofficeListBookViewController.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/16/24.
//

import UIKit

import DesignSystem

import RxSwift
import SnapKit
import Then

class NofficeListBookViewController: UIViewController {
    // MARK: Data
    private let listModel = ListModel(id: 1)
    
    // MARK: UI Components
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .fill
        $0.distribution = .fill
    }

    private lazy var selectionSegmentedControl = UISegmentedControl(
        items: ["Unselected", "Selected"]
    ).then {
        $0.selectedSegmentIndex = 0
    }

    private lazy var listView = NofficeList(option: listModel).then {
        $0.text = listModel.text
    }
    
    private lazy var radioGroupLabel = UILabel().then {
        $0.text = "With RadioGroup (+ grid)"
        $0.setTypo(.body1b)
        $0.textAlignment = .center
    }
    
    private lazy var listGroup = BaseRadioGroup(
        source: ListModel.factory(Array(0...3))
    ) { option in
        NofficeList(option: option).then {
            $0.text = "\(option.text) \(option.id)"
        }
    }.then {
        $0.gridStyled(columns: 2, verticalSpacing: 16, horizontalSpacing: 16)
    }
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(selectionSegmentedControl)
        stackView.addArrangedSubview(listView)
        stackView.addArrangedSubview(radioGroupLabel)
        stackView.addArrangedSubview(listGroup)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    private func setupBind() {
        selectionSegmentedControl.rx.selectedSegmentIndex
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                self.listView.isSelected = (index == 1)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Display model
extension NofficeListBookViewController {
    struct ListModel: Identifiable, Equatable {
        let id: Int
        let text: String = "Noffice List"
        
        static func factory(_ options: [Int]) -> [ListModel] {
            return options.map { ListModel(id: $0) }
        }
    }
}
