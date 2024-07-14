//
//  CardBookViewController.swift
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

final class CardBookViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView().then {
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
        items: Array(BasicCardVariant.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var colorControlLabel = UILabel().then {
        $0.text = "Color"
        $0.setTypo(.body1b)
    }
    
    private lazy var colorControl = UISegmentedControl(
        items: Array(BasicCardColor.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 3
    }
    
    private lazy var shapeControlLabel = UILabel().then {
        $0.text = "Shape"
        $0.setTypo(.body1b)
    }
    
    private lazy var shapeControl = UISegmentedControl(
        items: Array(BasicCardShape.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var paddingControlLabel = UILabel().then {
        $0.text = "Padding"
        $0.setTypo(.body1b)
    }
    
    private lazy var paddingControl = UISegmentedControl(
        items: Array(BasicCardPadding.allCases).map { $0.rawValue }
    ).then {
        $0.selectedSegmentIndex = 1
    }
    
    // MARK: - Card with button
    private lazy var okButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "OK"
                    $0.setTypo(.body2)
                }
            ]
        }).then {
            $0.styled(color: .green)
        }
    
    private lazy var cancelButton = BaseButton(
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "Cancel"
                    $0.setTypo(.body2)
                }
            ]
        }).then {
            $0.styled(color: .ghost)
        }
    
    private lazy var card = BaseCard(
        headerBuilder: {
            [
                UILabel().then {
                    $0.text = "Card"
                    $0.setTypo(.heading4)
                },
                UILabel().then {
                    $0.text = "This is a card"
                    $0.textColor = .grey500
                    $0.setTypo(.body1)
                }
            ]
        },
        contentsBuilder: {
            [
                UILabel().then {
                    $0.text = "content section"
                    $0.setTypo(.body2)
                },
                UILabel().then {
                    $0.text = "Anything can be combined here: labels, text fields, images, and more."
                    $0.numberOfLines = 2
                    $0.setTypo(.body2)
                }
            ]
        },
        footerBuilder: { [weak self] in
            guard let self = self else { return [] }
            return [self.okButton, self.cancelButton]
        }
    ).then {
        $0.styled()
    }
    
    private lazy var cardWithImageLabel = UILabel().then {
        $0.text = "With image"
        $0.setTypo(.body1b)
    }
    
    // MARK: - Card with image (별도로 컴포넌트화 필요)
    private lazy var cardWithImage = BaseCard(
        contentsBuilder: {
            [
                UIImageView(image: .imgNottiLetter).then {
                    $0.setSize(height: 160)
                    $0.contentMode = .scaleAspectFill
                    $0.clipsToBounds = true
                },
                BaseHStack {[
                    BaseSpacer(size: 20, orientation: .horizontal),
                    BaseVStack {[
                        BaseSpacer(size: 8, orientation: .vertical),
                        UILabel().then {
                            $0.text = "5차 세션 : 최종 팀빌딩"
                            $0.setTypo(.heading3)
                        },
                        BaseSpacer(size: 2),
                        BaseDivider(),
                        BaseSpacer(size: 2),
                        BaseHStack {[
                            UIImageView(image: .iconCalendar).then {
                                $0.setSize(width: 24, height: 24)
                                $0.tintColor = .grey200
                            },
                            UILabel().then {
                                $0.text = "2024.06.29(토) 14:00"
                                $0.setTypo(.body2b)
                                $0.textColor = .grey600
                            }
                        ]},
                        BaseHStack {[
                            UIImageView(image: .iconMappin).then {
                                $0.setSize(width: 24, height: 24)
                                $0.tintColor = .grey200
                            },
                            UILabel().then {
                                $0.text = "ZEP"
                                $0.setTypo(.body2b)
                                $0.textColor = .grey600
                            }
                        ]},
                        BaseSpacer(size: 12, orientation: .vertical)
                    ]},
                    BaseSpacer(size: 20, orientation: .horizontal)
                ]}
            ]
        }
    ).then {
        $0.styled()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupBindings()
    }
    
    private func setupHierarchy() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(variantControlLabel)
        stackView.addArrangedSubview(variantControl)
        stackView.addArrangedSubview(colorControlLabel)
        stackView.addArrangedSubview(colorControl)
        stackView.addArrangedSubview(shapeControlLabel)
        stackView.addArrangedSubview(shapeControl)
        stackView.addArrangedSubview(paddingControlLabel)
        stackView.addArrangedSubview(paddingControl)
        
        stackView.addArrangedSubview(BaseSpacer())
        stackView.addArrangedSubview(BaseDivider())
        stackView.addArrangedSubview(BaseSpacer())
        
        stackView.addArrangedSubview(card)
        stackView.addArrangedSubview(cardWithImageLabel)
        stackView.addArrangedSubview(cardWithImage)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.height.equalTo(stackView.snp.height).offset(32)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).inset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
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
        
        paddingControl.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }
    
    private func setupBindings() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            variantControl.rx.selectedSegmentIndex,
            colorControl.rx.selectedSegmentIndex,
            shapeControl.rx.selectedSegmentIndex,
            paddingControl.rx.selectedSegmentIndex
        )
        .observe(on: MainScheduler.instance)
        .withUnretained(self)
        .subscribe(onNext: { owner, value in
            owner.card.styled(
                variant: BasicCardVariant.allCases[value.0],
                color: BasicCardColor.allCases[value.1],
                shape: BasicCardShape.allCases[value.2],
                padding: BasicCardPadding.allCases[value.3]
            )
            
            owner.cardWithImage.styled(
                variant: BasicCardVariant.allCases[value.0],
                color: BasicCardColor.allCases[value.1],
                shape: BasicCardShape.allCases[value.2],
                padding: BasicCardPadding.allCases[value.3]
            )
        })
        .disposed(by: disposeBag)
    }
    
    deinit {
        print("noffice card vc deinit")
    }
}
