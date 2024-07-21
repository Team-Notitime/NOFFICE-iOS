//
//  NofficeGroupCard.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import Assets

import SnapKit
import Then

public final class NofficeAnnouncementCard: UIView {
    // MARK: State
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
    
    public var state: NofficeAnnouncementCard.State = .default {
        didSet {
            updateByState()
        }
    }
    
    // MARK: UI Component
    // - default card
    private lazy var titleLabel = UILabel().then {
        $0.text = ""
        $0.setTypo(.body0b)
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
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
                    BaseVStack(spacing: 6) {[
                        BaseSpacer(size: 4, orientation: .vertical),
                        titleLabel,
                        BaseSpacer(size: 0),
                        BaseDivider(),
                        BaseSpacer(size: 2),
                        BaseHStack {[
                            UIImageView(image: .iconCalendar).then {
                                $0.setSize(width: 18, height: 18)
                                $0.tintColor = .grey200
                            },
                            dateLabel
                        ]},
                        BaseHStack {[
                            UIImageView(image: .iconMappin).then {
                                $0.setSize(width: 18, height: 18)
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
    
    // - loading card
    private lazy var loadingCard = BaseCard(
        contentsBuilder: {
            [
                BaseSpacer(size: 44),
                UIImageView(image: .imgNottiLoading).then {
                    $0.setSize(height: 130)
                    $0.contentMode = .scaleAspectFit
                },
                BaseSpacer(size: 10),
                UILabel().then {
                    $0.text = "수락을 기다리고 있어요"
                    $0.setTypo(.body1m)
                    $0.textColor = .grey600
                    $0.numberOfLines = 2
                    $0.textAlignment = .center
                },
                UILabel().then {
                    $0.text = "리더가 확인하고 있으니 조금만 기다려주세요!"
                    $0.setTypo(.body3)
                    $0.textColor = .grey400
                    $0.numberOfLines = 2
                    $0.textAlignment = .center
                },
                BaseSpacer(size: 44)
            ]
        }
    ).then {
        $0.styled(variant: .outline, color: .gray, padding: .none)
    }
    
    // - none card
    private lazy var noneCard = BaseCard(
        contentsBuilder: {
            [
                BaseSpacer(size: 54),
                UIImageView(image: .imgNottiX).then {
                    $0.setSize(height: 100)
                    $0.contentMode = .scaleAspectFit
                },
                BaseSpacer(size: 10),
                UILabel().then {
                    $0.text = "아직 등록된 노티가 없어요"
                    $0.setTypo(.body1m)
                    $0.textColor = .grey600
                    $0.numberOfLines = 2
                    $0.textAlignment = .center
                },
                UILabel().then {
                    $0.text = "앞으로 어떤 즐거운 이벤트가 있을까요?"
                    $0.setTypo(.body3)
                    $0.textColor = .grey400
                    $0.numberOfLines = 2
                    $0.textAlignment = .center
                },
                BaseSpacer(size: 54)
            ]
        }
    ).then {
        $0.styled(variant: .outline, color: .gray, padding: .none)
    }

    // MARK: Initializer
    public init() {
        super.init(frame: .zero)
        
        setupHierarchy()
        setupBind()
        setupLayout()
        updateByState()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupHierarchy()
        setupBind()
        setupLayout()
        updateByState()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(defaultCard)
        addSubview(loadingCard)
        addSubview(noneCard)
    }
    
    private func setupLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(ComponentConstant.organizationCardHeight)
        }
        
        defaultCard.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loadingCard.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        noneCard.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
public extension NofficeAnnouncementCard {
    enum State: String, CaseIterable {
        case `default`, loading, none
    }
}
