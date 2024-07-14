//
//  NofficeGroupCard.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import SnapKit
import Then

public class NofficeGroupCard: UIView {
    // MARK: Data source
    public var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    public var dateText: String = "" {
        didSet {
            dateLabel.text = dateText
        }
    }
    
    public var locationText: String = "" {
        didSet {
            locationLabel.text = locationText
        }
    }
    
    public var state: NofficeGroupCard.State = .default {
        didSet {
            updateByState()
        }
    }
    
    // MARK: UI Component
    private lazy var titleLabel = UILabel().then {
        $0.text = ""
        $0.setTypo(.heading3)
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.text = ""
        $0.setTypo(.body2b)
        $0.textColor = .grey600
    }
    
    private lazy var locationLabel = UILabel().then {
        $0.text = ""
        $0.setTypo(.body2b)
        $0.textColor = .grey600
    }
    
    private lazy var defaultCard = BaseCard(
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
                        titleLabel,
                        BaseSpacer(size: 2),
                        BaseDivider(),
                        BaseSpacer(size: 2),
                        BaseHStack {[
                            UIImageView(image: .iconCalendar).then {
                                $0.setSize(width: 24, height: 24)
                                $0.tintColor = .grey200
                            },
                            dateLabel
                        ]},
                        BaseHStack {[
                            UIImageView(image: .iconMappin).then {
                                $0.setSize(width: 24, height: 24)
                                $0.tintColor = .grey200
                            },
                            locationLabel
                        ]},
                        BaseSpacer(size: 12, orientation: .vertical)
                    ]},
                    BaseSpacer(size: 20, orientation: .horizontal)
                ]}
            ]
        }
    ).then {
        $0.styled(variant: .outline, color: .gray, padding: .none)
    }
    
    private var loadingCard = BaseCard(
        contentsBuilder: {
            [
                BaseVStack(alignment: .center, spacing: 20) {
                    [
                        BaseSpacer(size: 44),
                        UILabel().then {
                            $0.text = "리더의 수락을 \n기다리고 있어요"
                            $0.setTypo(.heading4)
                            $0.textColor = .grey400
                            $0.numberOfLines = 2
                            $0.textAlignment = .center
                        },
                        UIImageView(image: .imgNottiLoading).then {
                            $0.setSize(height: 130)
                            $0.contentMode = .scaleAspectFit
                        },
                        BaseSpacer(size: 44)
                    ]
                }
            ]
        }
    ).then {
        $0.styled(variant: .outline, color: .gray, padding: .none)
    }
    
    private var noneCard = BaseCard(
        contentsBuilder: {
            [
                BaseVStack(alignment: .center, spacing: 20) {
                    [
                        BaseSpacer(size: 60),
                        UILabel().then {
                            $0.text = "아직 등록된 \n노티가 없어요"
                            $0.setTypo(.heading4)
                            $0.textColor = .grey400
                            $0.numberOfLines = 2
                            $0.textAlignment = .center
                        },
                        UIImageView(image: .imgNottiX).then {
                            $0.setSize(height: 100)
                            $0.contentMode = .scaleAspectFit
                        },
                        BaseSpacer(size: 60)
                    ]
                }
            ]
        }
    ).then {
        $0.styled(variant: .outline, color: .gray, padding: .none)
    }
    
    private lazy var stackView = BaseVStack(
        contents: [defaultCard, loadingCard, noneCard]
    )
    
    // MARK: Initializer
    public init() {
        super.init(frame: .zero)
        
        setupHierarchy()
        setupBind()
        
        updateByState()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupHierarchy()
        setupBind()
        
        updateByState()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateByState() {
        defaultCard.isHidden = (state != .default)
        loadingCard.isHidden = (state != .loading)
        noneCard.isHidden = (state != .none)
    }
}

// MARK: - Display model
public extension NofficeGroupCard {
    enum State: String, CaseIterable {
        case `default`, loading, none
    }
}
