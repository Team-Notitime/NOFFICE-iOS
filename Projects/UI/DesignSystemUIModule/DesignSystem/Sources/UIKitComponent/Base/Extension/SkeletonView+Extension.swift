//
//  SkeletonView+Extension.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/26/24.
//

import UIKit

import SkeletonView

public extension UIView {
    /// 여러 뷰들의 `isSkeletonable` 속성을 설정하면서 특정 루트 뷰까지의 경로를 탐색하여 설정합니다.
    func setSkeletonableForViews(_ views: [UIView], rootView: UIView) {
        for view in views {
            var currentView: UIView? = view
            
            while let view = currentView {
                view.isSkeletonable = true
                if view == rootView {
                    break
                }
                currentView = view.superview
            }
        }
    }
    
    /// 특정 뷰와 해당 뷰까지 가는 경로에 있는 뷰들의 `isSkeletonable` 속성을 재귀적으로 설정합니다.
    func setSkeletonablePath(to targetView: UIView) {
        guard targetView.isDescendant(of: self) else { return }
        
        var currentView: UIView? = targetView
        
        while let view = currentView, view != self {
            view.isSkeletonable = true
            currentView = view.superview
        }
        
        self.isSkeletonable = true
    }
    
    /// 특정 뷰와 그 하위 뷰의 `isSkeletonable` 속성을 재귀적으로 설정합니다.
    func setSkeletonableRecursively() {
        self.isSkeletonable = true
        for subview in self.subviews {
            subview.setSkeletonableRecursively()
        }
    }
}
