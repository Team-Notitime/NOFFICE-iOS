//
//  DialogContentView.swift
//  DesignSystemModule
//
//  Created by HUNHEE LEE on 9.01.2025.
//

import UIKit

public class DialogContentView: UIView {
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .grey800
        $0.setTypo(.body1m)
    }
    
    let descriptionLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .grey500
        $0.setTypo(.body3m)
    }
    
    public init(
        icon: UIImage? = nil,
        title: String,
        message: String
    ) {
        super.init(frame: .zero)
        
        iconImageView.image = icon
        titleLabel.text = title
        descriptionLabel.text = message
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupHierarchy() {
        if iconImageView.image != nil {
            addSubview(iconImageView)
        }
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    private func setupLayout() {
        if iconImageView.image != nil {
            iconImageView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.centerX.equalToSuperview()
                $0.height.equalTo(113)
            }
            
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(iconImageView.snp.bottom).offset(10)
                $0.left.right.equalToSuperview()
            }
        } else {
            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.left.right.equalToSuperview()
            }
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
