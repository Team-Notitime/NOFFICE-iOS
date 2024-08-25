//
//  PaginableView.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/13/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

public protocol Paginable: Hashable {
    var viewController: UIViewController { get }
}

/**
 A view that can scroll by pages.

 First, define the types of pages to be displayed as an enumeration.
 This enumeration is also used to determine which page to move to in a clear way, not by index.
 ```swift
 enum TestViewPage: Paginable {
     case first
     case second
     case third
     
     var viewController: UIViewController {
         switch self {
         case .first:
             let vc = UIViewController()
             vc.view.backgroundColor = .gray02
             return vc
         case .second:
             let vc = UIViewController()
             vc.view.backgroundColor = .gray03
             return vc
         case .third:
             let vc = UIViewController()
             vc.view.backgroundColor = .gray05
             return vc
         }
     }
 }
```
 
 Create an RxPageViewController using the defined enumeration
 and inject the pages to be displayed into the initializer.
 - Important: The elements of the page array must not be duplicated.
 The recommended approach is to use allCases.
 ```swift
 // 1. Create a PageView with pages.
 let paginableView = PaginableView<TestViewPage>(pages: [.first, .second, third])
 
 // 2. Add the PageView to the parent view.
 addSubview(paginableView)
 paginableView.snp.makeConstraints { make in
     make.edges.equalToSuperview()
 }
 
 // 3. Subscribe the onMove action. You can observe when the page changes by dragging.
 paginableView.onMove
     .subscribe(onNext: { page in
         print(page) // result: first or second or third
     })
     .disposed(by: disposeBag)
 
 // 4. Bind the some subject to moveTo. This allows you to programmatically move to a specific page.
 someSubject
     .bind(to: paginableView.moveTo)
     .disposed(by: disposeBag)
 ```
 
 If you want to change the page configuration at runtime, use the ``updatePages(_:)`` method.
- Warning: There is no problem modifying the previous view, the next view,
 but if you delete the page you are currently showing, unexpected behavior can occur.
 ```swift
 paginableView.updatePages([.first, .second])
 ```
 */
@MainActor
open class PaginableView<Page: Paginable>: UIView, UIScrollViewDelegate {
    // MARK: Event
    private let _onMove = PublishSubject<Page>()
    public var onMove: Observable<Page> {
        return _onMove.asObservable()
    }
    
    public var currentPage: Page? {
        didSet {
            guard let selectedPage = currentPage,
                  let pageIndex = pages.firstIndex(of: selectedPage) else { return }
            moveToPage(at: pageIndex, animated: true)
        }
    }
    
    /// Indicates whether the page can be moved using swipe gestures. The default is true.
    public var gestureScrollEnabled: Bool {
        get { scrollView.isScrollEnabled }
        set { scrollView.isScrollEnabled = newValue }
    }
    
    private let _scrollOffset = PublishSubject<CGFloat>()
    public var scrollOffset: Observable<Page> {
        return _onMove.asObservable()
    }
    
    // MARK: Private property
    private var pages: [Page] = []
    
    private let firstPage: Page
    
    private var viewControllersDict: [Page: UIViewController] = [:]
    
    private var pageIndexDict: [Page: Int] = [:]
    
    // MARK: UI component
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public init(
        pages: [Page],
        firstPage: Page
    ) {
        self.firstPage = firstPage
        
        super.init(frame: .zero)
        
        if pages.isEmpty {
            fatalError("You must provide at least one page.")
        }
        
        if !pages.contains(firstPage) {
            fatalError("The first page must be included in the page list.")
        }
        
        if pages.count != Set(pages).count {
            fatalError("There are duplicate pages.")
        }
        
        setupPages(pages)
        setupScrollView()
        setupContentView()
        setupFirstPage()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupPageLayout()
    }
    
    // MARK: Public method
    public func updatePages(_ pages: [Page]) {
        if pages.count != Set(pages).count {
            fatalError("There are duplicate pages.")
        }
        
        setupPages(pages)
        updatePageLayout()
    }
    
    // MARK: Setup
    private func setupPages(_ pages: [Page]) {
        self.pages = pages
        viewControllersDict.removeAll()
        pages.enumerated().forEach { index, page in
            viewControllersDict[page] = page.viewController
            pageIndexDict[page] = index
        }
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.alwaysBounceHorizontal = false
        
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width)
                .multipliedBy(CGFloat(pages.count))
        }
    }
    
    private func setupPageLayout() {
        for (index, page) in pages.enumerated() {
            if let viewController = viewControllersDict[page] {
                contentView.addSubview(viewController.view)
                
                viewController.view.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(scrollView.snp.width)
                    make.leading.equalTo(scrollView.snp.leading)
                        .offset(scrollView.bounds.width * CGFloat(index))
                }
            }
        }
    }
    
    private func setupFirstPage() {
        guard let firstPageIndex = pageIndexDict[firstPage]
        else { return }
        
        currentPage = firstPage
        scrollView.contentOffset = CGPoint(
            x: scrollView.bounds.width * CGFloat(firstPageIndex),
            y: 0
        )
    }
    
    // MARK: Update
    private func updatePageLayout() {
        let existingViews = Set(contentView.subviews)
        var newViews: Set<UIView> = []
        
        // Iterate over pages array and configure the view for each page
        for (index, page) in pages.enumerated() {
            if let viewController = viewControllersDict[page],
                let view = viewController.view {
                
                newViews.insert(view)
                
                // If the view is not already in the existingViews, add it to contentView
                if !existingViews.contains(view) {
                    contentView.addSubview(view)
                }
                
                view.snp.remakeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(scrollView.snp.width)
                    make.leading.equalTo(scrollView.snp.leading)
                        .offset(scrollView.bounds.width * CGFloat(index))
                }
            }
        }
        
        // Remove views that are no longer needed
        for view in existingViews.subtracting(newViews) {
            view.removeFromSuperview()
        }
        
        // Remake constraints for contentView to fit all pages
        contentView.snp.remakeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width)
                .multipliedBy(CGFloat(pages.count))
        }
        
        // Ensure the scroll view is positioned correctly for the selected page
        guard let selectedPage = currentPage,
                let selectedPageIndex = pageIndexDict[selectedPage]
        else { return }
        
        scrollView.contentOffset = CGPoint(
            x: scrollView.bounds.width * CGFloat(selectedPageIndex),
            y: 0
        )
    }

    private func moveToPage(at index: Int, animated: Bool) {
        scrollView.setContentOffset(
            CGPoint(
                x: scrollView.bounds.width * CGFloat(index),
                y: 0
            ),
            animated: animated
        )
    }
    
    // MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        _scrollOffset.onNext(offsetX)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        currentPage = pages[pageIndex]
        _onMove.onNext(pages[pageIndex])
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        currentPage = pages[pageIndex]
        _onMove.onNext(pages[pageIndex])
    }
}
