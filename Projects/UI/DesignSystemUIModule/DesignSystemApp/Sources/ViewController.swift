//
//  ViewController.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit

import DesignSystem

import RxSwift
import RxCocoa
import Then
import SnapKit

class ViewController: UIViewController {
    // MARK: UI Component
    private lazy var iconImage = UIImageView().then {
        $0.image = .dsLogo
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "Noffice design system example"
        $0.setTypo(.heading2)
        $0.numberOfLines = 2
    }
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    private lazy var buttonBookButton = UIButton().then {
        $0.setTitle("Basic button example", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    private lazy var textFieldBookButton = UIButton().then {
        $0.setTitle("Basic text field example", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
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
        stackView.addArrangedSubview(iconImage)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(buttonBookButton)
        stackView.addArrangedSubview(textFieldBookButton)
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
            make.width.equalTo(contentView).offset(-32) // Offset width to account for insets
        }
        
        iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
    }
    
    private func setupBind() {
        buttonBookButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let viewController = ButtonBookViewController()
                self?.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        textFieldBookButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let viewController = TextFieldBookViewController()
                self?.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
