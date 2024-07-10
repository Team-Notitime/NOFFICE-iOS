//
//  TabBarItem.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/10/24.
//

import Foundation

public enum TabBarItem: Int, CaseIterable {
    case home = 0
    case group = 1
    case announce = 2 // This item is not part of the TabBarITem. This item floats above the TabBar.
    
    var tag: Int { rawValue }
}
