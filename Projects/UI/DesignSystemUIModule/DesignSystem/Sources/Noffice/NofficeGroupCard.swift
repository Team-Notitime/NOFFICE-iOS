//
//  NofficeGroupCard.swift
//  DesignSystemApp
//
//  Created by DOYEON LEE on 7/14/24.
//

import UIKit

import SnapKit
import Then

public class GroupCardView: UIView {
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
    
    private lazy var card = BaseCard(
        contentBuilder: {[weak self] in
            guard let self = self else { return [] }
            
            return [
                UIImageView(image: .imgNottiLetter).then {
                    $0.setSize(height: 160)
                    $0.contentMode = .scaleAspectFill
                    $0.clipsToBounds = true
                },
                BaseHStack {[
                    BaseSpacer(size: 20, orientation: .horizontal),
                    BaseVStack {[
                        BaseSpacer(size: 8, orientation: .vertical),
                        self.titleLabel,
                        BaseSpacer(size: 2),
                        BaseDivider(),
                        BaseSpacer(size: 2),
                        BaseHStack {[
                            UIImageView(image: .iconCalendar).then {
                                $0.setSize(width: 24, height: 24)
                                $0.tintColor = .grey200
                            },
                            self.dateLabel
                        ]},
                        BaseHStack {[
                            UIImageView(image: .iconMappin).then {
                                $0.setSize(width: 24, height: 24)
                                $0.tintColor = .grey200
                            },
                            self.locationLabel
                        ]},
                        BaseSpacer(size: 12, orientation: .vertical)
                    ]},
                    BaseSpacer(size: 20, orientation: .horizontal)
                ]}
            ]
        }
    ).then {
        $0.styled(variant: .outline, color: .gray)
    }
    
    // MARK: Initializer
    public init() {
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        addSubview(card)
    }
    
    private func setupLayout() {
        card.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBind() { }
}
