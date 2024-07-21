//
//  TodoSectionModel.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/21/24.
//

import UIKit

import DesignSystem
import Assets

import RxSwift

struct TodoSectionModel: CompositionalLayoutModelType {
    var itemStrategy: SizeStrategy = .item(
        widthDimension: .absolute(1.0),
        heightDimension: .absolute(30)
    )
    
    var groupStrategy: SizeStrategy = .group(
        widthDimension: .absolute(1.0),
        heightDimension: .absolute(140)
    )
    
    var headerStrategy: SizeStrategy? = .header(
        widthDimension: .absolute(1.0),
        heightDimension: .absolute(50)
    )
    
    var footerStrategy: SizeStrategy?
    
    var groupSpacing: CGFloat = 8.0
    
    var sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(
        top: 0,
        leading: 0,
        bottom: 0,
        trailing: 0
    )
    
    var scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
}
