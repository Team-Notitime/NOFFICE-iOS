//
//  NofficeBanner.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/15/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

public final class NofficeBanner: UIView {
    // MARK: State
    private var _userName: String = ""
    public var userName: String {
        get { _userName }
        set {
            if _userName != newValue {
                _userName = newValue
                updateText()
            }
        }
    }
    
    private var _todayPrefixText: String = ""
    public var todayPrefixText: String {
        get { _todayPrefixText }
        set {
            if _todayPrefixText != newValue {
                _todayPrefixText = newValue
                updateText()
            }
        }
    }
    
    private var _dateText: String = ""
    public var dateText: String {
        get { _dateText }
        set {
            if _dateText != newValue {
                _dateText = newValue
                updateText()
            }
        }
    }
    
    // MARK: UI Constant
    private static let BannerHeight: CGFloat = 105
    
    private static let TextLeftPadding: CGFloat = 16
    
    private static let TextBottomPadding: CGFloat = 8
    
    private static let TextSize: CGFloat = 24
    
    // MARK: UI Component
    private lazy var bannerImage = UIImageView(image: .imgBannerBackground).then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private lazy var textLabel = UILabel().then {
        $0.numberOfLines = 0
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
        addSubview(bannerImage)
        
        bannerImage.addSubview(textLabel)
    }
    
    private func setupLayout() {
        bannerImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Self.BannerHeight)
        }
        
        textLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
                .inset(Self.TextLeftPadding)
            $0.bottom.equalToSuperview()
                .inset(Self.TextBottomPadding)
        }
    }
    
    private func setupBind() { }
    
    // MARK: Update
    private func updateText() {
        let fullText = "\(userName)님, \(todayPrefixText) 오늘은\n\(dateText)이에요!"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // 줄 간격 설정
           let paragraphStyle = NSMutableParagraphStyle()
           paragraphStyle.lineSpacing = 6
        
        // 전체 텍스트의 스타일
        attributedString.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: Self.TextSize),
            range: NSRange(location: 0, length: fullText.count)
        )
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.grey800,
            range: NSRange(location: 0, length: fullText.count)
        )
        attributedString.addAttribute(
            .paragraphStyle, 
            value: paragraphStyle,
            range: NSRange(location: 0, length: fullText.count)
        )
        
        // 특정 텍스트의 스타일 (userName 부분)
        if let userNameRange = fullText.range(of: userName) {
            let nsRange = NSRange(userNameRange, in: fullText)
            attributedString.addAttribute(
                .font,
                value: UIFont.boldSystemFont(ofSize: Self.TextSize),
                range: nsRange
            )
        }
        
        // 특정 텍스트의 스타일 (dateText 부분)
        if let dateTextRange = fullText.range(of: dateText) {
            let nsRange = NSRange(dateTextRange, in: fullText)
            attributedString.addAttribute(
                .font,
                value: UIFont.boldSystemFont(ofSize: Self.TextSize),
                range: nsRange
            )
        }
        
        textLabel.attributedText = attributedString
    }
}
