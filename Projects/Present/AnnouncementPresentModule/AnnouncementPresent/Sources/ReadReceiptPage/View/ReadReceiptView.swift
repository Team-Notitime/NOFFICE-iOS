//
//  ReadReceiptView.swift
//  AnnouncementPresent
//
//  Created by DOYEON LEE on 9/29/24.
//

import UIKit

import DesignSystem
import Assets

import SnapKit
import Then

final class ReadReceiptView: BaseView {
    // MARK: UI Constant
    
    // MARK: UI Component
    lazy var readStateSegment = BaseSegmentControl<ReadState>(
        source: [
            .read,
            .unread
        ],
        itemBuilder: { option in
            [
                UILabel().then {
                    $0.text = option.description
                    $0.setTypo(.body1b)
                }
            ]
        }
    )
    
    // MARK: Setup
    override func setupHierarchy() {
        addSubview(readStateSegment)
    }
    
    override func setupLayout() {
        readStateSegment.snp.makeConstraints {
            $0.top.equalToSuperview()
                .inset(16)
            $0.leading.trailing.equalToSuperview()
                .inset(20)
        }
    }
}

enum ReadState: String, Identifiable {
    case read
    case unread
    
    var id: String {
        self.rawValue
    }
    
    var description: String {
        switch self {
        case .read:
            return "확인했어요"
        case .unread:
            return "아직이에요"
        }
    }
}
