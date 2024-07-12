//
//  CustomPageViewController.swift
//  DesignSystem
//
//  Created by DOYEON LEE on 7/13/24.
//

import UIKit
import RxSwift
import RxCocoa

/**
 페이지 단위로 스크롤 가능한 뷰

 First, define the types of pages to be displayed as an enumeration.
 This enumeration is also used to determine which page to move to in a clear way, not by index.
 Thus, for all pages to be displayed, define the enumeration as follows:
 ```swift
 enum TestViewPage: PageType {
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
 ```swift
 // 1. Create a RxPabeViewCotnroller with pages.
 let pageViewController = PageViewController<TestViewPage>(pages: [.first, .second, third])
 
 // 2. Add the RxPageViewController to the parent view.
 addSubview(pageViewController.view)
 pageViewController.view.snp.makeConstraints { make in
     make.edges.equalToSuperview()
 }
 
 // 3. Subscribe the onMove action. You can observe when the page changes by dragging.
 pageViewController.onMove
     .subscribe(onNext: { page in
         print(page) // result: first or second or third
     })
     .disposed(by: disposeBag)
 
 // 4. Bind the some subject to moveTo. This allows you to programmatically move to a specific page.
 someSubject
     .bind(to: pageViewController.moveTo)
     .disposed(by: disposeBag)
 ```
 
 If you want to change the page configuration at runtime, use the updatePages(_:) method.
- Note: Even if you remove the current page from the configuration,
 it will not be removed from the screen immediately. Use this to modify the previous or next page.
 ```swift
 pageViewController.updatePages([.first, .second])
 ```
 */
public protocol PageType: Hashable {
    var viewController: UIViewController { get }
}

open class PageViewController<Page: PageType>: UIViewController, UIScrollViewDelegate {
    // MARK: Event
    public let _onMove = PublishSubject<Page>()
    public var onMove: Observable<Page> {
        return _onMove.asObservable()
    }
    
    public var selectedPage: Binder<Page> {
        return Binder(self) { (pageViewController: PageViewController, page: Page) in
            guard let pageIndex = pageViewController.pages.firstIndex(of: page) else { return }
            pageViewController.moveToPage(at: pageIndex, animated: true)
        }
    }
    
    // MARK: Private property
    private var pages: [Page] = []
    private let firstPage: Page
    private var viewControllersDict: [Page: UIViewController] = [:]
    private var currentPageIndex: Int?
    
    // MARK: UI component
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: DisposeBag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public init(pages: [Page], firstPage: Page) {
        self.firstPage = firstPage
        super.init(nibName: nil, bundle: nil)
        
        if pages.isEmpty {
            fatalError("You must provide at least one page.")
        }
        
        if !pages.contains(firstPage) {
            fatalError("The first page must be included in the page list.")
        }
        
        if pages.count != Set(pages).count {
            fatalError("There are duplicate pages.")
        }
        updatePages(pages)
        setupScrollView()
        setupContentView()
        setupFirstPage()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPages()
        setupFirstPage()

    }
    
    // MARK: Public interface
    public func updatePages(_ pages: [Page]) {
        if pages.count != Set(pages).count {
            fatalError("There are duplicate pages.")
        }
        
        self.pages = pages
        viewControllersDict.removeAll()
        pages.forEach { page in
            viewControllersDict[page] = page.viewController
        }
    }
    
    // MARK: Setup
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width).multipliedBy(CGFloat(pages.count))
        }
    }
    
    private func setupFirstPage() {
        guard let firstViewController = viewControllersDict[firstPage],
              let firstPageIndex = pages.firstIndex(of: firstPage)
        else { return }
        
        currentPageIndex = firstPageIndex
        scrollView.contentOffset = CGPoint(
            x: scrollView.bounds.width * CGFloat(firstPageIndex),
            y: 0
        )
    }
    
    private func setupPages() {
        for (index, page) in pages.enumerated() {
            if let viewController = viewControllersDict[page] {
                addChild(viewController)
                contentView.addSubview(viewController.view)
                viewController.didMove(toParent: self)
                
                viewController.view.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(scrollView.snp.width)
                    make.leading.equalTo(scrollView.snp.leading)
                        .offset(scrollView.bounds.width * CGFloat(index))
                    
                    print(scrollView.bounds.width)
                }
            }
        }
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
        let width = scrollView.bounds.width
        let pageIndex = Int((offsetX + width / 2) / width)
        if pageIndex != currentPageIndex {
            currentPageIndex = pageIndex
            _onMove.onNext(pages[pageIndex])
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        currentPageIndex = pageIndex
        _onMove.onNext(pages[pageIndex])
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        currentPageIndex = pageIndex
        _onMove.onNext(pages[pageIndex])
    }
}
