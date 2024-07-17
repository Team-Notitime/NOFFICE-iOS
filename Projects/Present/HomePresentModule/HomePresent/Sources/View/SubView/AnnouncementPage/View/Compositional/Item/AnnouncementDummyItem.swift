//
//  AnnouncementDummyItem.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/17/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

final class AnnouncementDummyItem: CompositionalItem {
    typealias Cell = AnnouncementDummyItemCell
    
    // MARK: Data
    let identifier: String = UUID().uuidString
    
    // MARK: Initializer
    init( ) { }
    
    // MARK: Hasher
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

final class AnnouncementDummyItemCell: UIView, CompositionalItemCell {
    
    // MARK: DisposeBag
    private var disposeBag = DisposeBag()
    
    // MARK: Initializer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        self.backgroundColor = .grey50
        
        self.layer.cornerRadius = 16
    }
    
    func configure(with item: AnnouncementDummyItem) { }
}
