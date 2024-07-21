//
//  OrganizationRow.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/21/24.
//

import UIKit

import Assets

import RxSwift
import SnapKit
import Then

final class NofficeOrganizationRow: UIControl {
    // MARK: Event
    private var _onTap: PublishSubject<Void> = PublishSubject()
    public var onTap: Observable<Void> {
        return _onTap.asObservable()
    }
    
    // MARK: Data
    public var organizationName: String = "" {
        didSet {
            organizationNameLabel.text = organizationName
        }
    }
    
    // MARK: UIConstant
    private let padding: CGFloat = 16
    
    private let imageSize: CGFloat = 48
    
    // MARK: UI Component
    lazy var organizationImage = UIImageView(image: .imgProfileGroup).then {
        $0.setSize(width: imageSize, height: imageSize)
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }
    
    lazy var organizationNameLabel = UILabel().then {
        $0.setTypo(.body1b)
        $0.textColor = .grey800
    }
    
    lazy var moreIcon = UIImageView(image: .iconChevronRight).then {
        $0.tintColor = .grey400
        $0.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        addSubview(organizationImage)
        
        addSubview(organizationNameLabel)
        
        addSubview(moreIcon)
        
        organizationImage.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview().inset(padding)
        }
        
        organizationNameLabel.snp.makeConstraints {
            $0.left.equalTo(organizationImage.snp.right).offset(padding)
            $0.centerY.equalTo(organizationImage.snp.centerY)
        }
        
        moreIcon.snp.makeConstraints {
            $0.right.equalToSuperview().inset(padding)
            $0.centerY.equalTo(organizationImage.snp.centerY)
        }
        
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
    
    // MARK: UIControl handling
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("start tap")
        UIView.transition(
            with: self,
            duration: 0.2,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                guard let self = self else { return }

                self.backgroundColor = .grey50
                self.transform = .init(scaleX: 0.9, y: 0.9)
            }
        )
        return true
    }
    
    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        print("end tap")
        UIView.transition(
            with: self,
            duration: 0.2,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                guard let self = self else { return }

                self.backgroundColor = nil
                self.transform = .identity
            }
        )
        _onTap.onNext(())
        sendActions(for: .touchUpInside)
    }
    
    override public func cancelTracking(with event: UIEvent?) {
        backgroundColor = nil
        transform = .identity
    }
}
