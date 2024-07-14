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
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
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
    
    private lazy var segments: [Section] = [
        Section(
            title: "Button",
            examples: [
                Example(
                    button: UIButton().then {
                        $0.setTitle("Basic Button example", for: .normal)
                        $0.setTitleColor(.systemBlue, for: .normal)
                    },
                    viewController: ButtonBookViewController.self
                )
            ]
        ),
        Section(
            title: "TextField",
            examples: [
                Example(
                    button: UIButton().then {
                        $0.setTitle("Basic text field example", for: .normal)
                        $0.setTitleColor(.systemBlue, for: .normal)
                    },
                    viewController: TextFieldBookViewController.self
                )
            ]
        ),
        Section(
            title: "Badge",
            examples: [
                Example(
                    button: UIButton().then {
                        $0.setTitle("Basic badge example", for: .normal)
                        $0.setTitleColor(.systemBlue, for: .normal)
                    },
                    viewController: BadgeBookViewController.self
                )
            ]
        ),
        Section(
            title: "Dialog",
            examples: [
                Example(
                    button: UIButton().then {
                        $0.setTitle("Basic dialog example", for: .normal)
                        $0.setTitleColor(.systemBlue, for: .normal)
                    },
                    viewController: DialogBookViewController.self
                )
            ]
        ),
        Section(
            title: "SegmentControl",
            examples: [
                Example(
                    button: UIButton().then {
                        $0.setTitle("Basic segment control example", for: .normal)
                        $0.setTitleColor(.systemBlue, for: .normal)
                    },
                    viewController: SegmentControlBookViewController.self
                )
            ]
        ),
        Section(
            title: "Card",
            examples: [
                Example(
                    button: UIButton().then {
                        $0.setTitle("Basic card example", for: .normal)
                        $0.setTitleColor(.systemBlue, for: .normal)
                    },
                    viewController: CardBookViewController.self
                )
            ]
        ),
        Section(
            title: "Noffice",
            examples: [
                Example(
                    label: "Group card",
                    button: UIButton().then {
                        $0.setTitle("Example", for: .normal)
                        $0.setTitleColor(.systemBlue, for: .normal)
                    },
                    viewController: NofficeGroupCardBookViewController.self
                ),
                Example(
                    label: "Todo",
                    button: UIButton().then {
                        $0.setTitle("Example", for: .normal)
                        $0.setTitleColor(.systemBlue, for: .normal)
                    },
                    viewController: NofficeTodoBookViewController.self
                ),
                Example(
                    label: "Banner",
                    button: UIButton().then {
                        $0.setTitle("Example", for: .normal)
                        $0.setTitleColor(.systemBlue, for: .normal)
                    },
                    viewController: NofficeBannerBookViewController.self
                )
            ]
        )
    ]
    
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
        stackView.addArrangedSubview(BaseSpacer(size: 8))
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(BaseSpacer(size: 16))
        
        segments.forEach { segment in
            let titleLabel = UILabel().then {
                $0.text = segment.title
                $0.setTypo(.body0b)
            }
            stackView.addArrangedSubview(titleLabel)
            segment.examples.forEach { example in
                if let label = example.label {
                    let exampleLabel = UILabel().then {
                        $0.text = label
                        $0.setTypo(.body2b)
                    }
                    stackView.addArrangedSubview(exampleLabel)
                }
                stackView.addArrangedSubview(example.button)
                stackView.addArrangedSubview(BaseSpacer(size: 8))
            }
        }
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
        segments.forEach { segment in
            segment.examples.forEach { example in
                example.button.rx.tap
                    .subscribe(onNext: { [weak self] in
                        let viewController = example.viewController.init()
                        self?.navigationController?.pushViewController(viewController, animated: true)
                    })
                    .disposed(by: disposeBag)
            }
        }
    }
}

// MARK: - Display model
extension ViewController {
    struct Example {
        var label: String?
        let button: UIButton
        let viewController: UIViewController.Type
    }
    
    struct Section {
        let title: String
        let examples: [Example]
    }
}
