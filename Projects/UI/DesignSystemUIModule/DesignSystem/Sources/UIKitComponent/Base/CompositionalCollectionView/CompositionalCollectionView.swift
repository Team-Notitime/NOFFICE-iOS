//
//  CompositionalCollectionView.swift
//
//  Created by DOYEON LEE on 7/11/24.
//
//  Refer to MUMU
//

import UIKit

import RxSwift

final public class CompositionalCollectionView: 
    UIView, UICollectionViewDelegate {
    // MARK: Identifier
    private let itemCellIdentifier = CollectionViewItemCellContainer.reusableIdentifier
    
    private let reusableViewIdentifier = CollectionViewResuableViewContainer.reusableIdentifier
    
    // MARK: Public
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            collectionView.contentInset = contentInset
        }
    }
    
    public var verticalBouncy: Bool = true {
        didSet {
            collectionView.bounces = verticalBouncy
        }
    }
    
    /// Indicates whether the collection view can scroll. If false, the collection view will not scroll.
    /// - Note: When scrolling is disabled, the height of the collection view is automatically calculated and applied.
    public var isScrollEnabled: Bool = true {
        didSet {
            collectionView.isScrollEnabled = isScrollEnabled
            
            // Calculate and set height when scrolling is disabled
            if !isScrollEnabled {
                setCollectionViewHeightToSelf()
            }
        }
    }
    
    public var contentSize: CGSize? {
        didSet {
            _onChangeContentSize.onNext(contentSize)
        }
    }
    
    private let _onChangeContentSize = PublishSubject<CGSize?>()
    public var onChangeContentSize: Observable<CGSize?> {
        return _onChangeContentSize.asObservable()
    }
    
    // MARK: CollectionView & DataSource
    private var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<
        CompositionalSectionWrapper, CollectionViewItemWrapper
    >!
    
    // MARK: Injected data
    private var sections: [CompositionalSectionWrapper] = [] {
        didSet {
            applySnapshot(animatingDifferences: true)
        }
    }
    
    // MARK: Disposebag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    public init() {
        super.init(frame: .zero)
        configureCompositionalLayout()
        configureDatasource()
        configureCollectionView()
        setupBind()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public interface for RxSwift
    public var sectionBinder: Binder<[any CompositionalSection]> {
        return Binder(self) { compositionalView, newSections in
            compositionalView.sections = newSections.map {
                CompositionalSectionWrapper(wrappee: $0)
            }
        }
    }
    
    public func bindSections(
        to sectionsObservable: Observable<[any CompositionalSection]>
    ) -> Disposable {
        let sectionsDisposable = sectionsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] newSections in
                guard let self = self else { return }
                self.sections = newSections.map {
                    CompositionalSectionWrapper(wrappee: $0)
                }
            })
        
        return Disposables.create([sectionsDisposable])
    }
    
    // MARK: Configure collection view
    /// Set the compositional layout of collection view using the sections
    private func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            return self?.sections[sectionIndex].wrappee.layout.makeSectionLayout()
        }
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
    }
    
    /// Set the diffable datasource and cell dequeue logic
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<
            CompositionalSectionWrapper, CollectionViewItemWrapper
        >(
            collectionView: collectionView
        ) { [weak self] (collectionView, indexPath, itemWrapper) in
            guard let self = self else { return UICollectionViewCell() }
            
            // Dequeue cell and cast container cell type
            guard let containerCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: self.itemCellIdentifier,
                for: indexPath
            ) as? CollectionViewItemCellContainer else {
                return UICollectionViewCell()
            }
            
            // Configure inner view of container cell
            let cellType = itemWrapper.wrappee.cellType
            let cell = cellType.init()
            
            containerCell.setContainedCell(cell)
            containerCell.configure(with: itemWrapper.wrappee)
            
            return containerCell
        }

        configureDatasourceSupplementary()
        
        applySnapshot()
    }
    
    /// Set the supplementary view provider
    private func configureDatasourceSupplementary() {
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath)
            -> UICollectionReusableView? in
            guard let self = self else { return nil }
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: self.reusableViewIdentifier,
                    for: indexPath
                ) as? CollectionViewResuableViewContainer else {
                    return UICollectionReusableView()
                }
                
                // Configure inner view of container cell
                let headerType = section.wrappee.headerType
                let view = headerType.init()
                
                headerView.setContainedView(view)
                headerView.configure(with: section.wrappee, type: .header)
                
                return headerView
            } else if kind == UICollectionView.elementKindSectionFooter {
                guard let footerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: self.reusableViewIdentifier,
                    for: indexPath
                ) as? CollectionViewResuableViewContainer else {
                    return UICollectionReusableView()
                }
                
                // Configure inner view of container cell
                let footerType = section.wrappee.footerType
                let view = footerType.init()
                
                footerView.setContainedView(view)
                footerView.configure(with: section.wrappee, type: .footer)
                
                return footerView
            }
            
            return nil
        }
    }
    
    /// Set the collection view layout (relative to the parent view) and delegate
    private func configureCollectionView() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }
    
    // MARK: Snapshot
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<CompositionalSectionWrapper, CollectionViewItemWrapper>()
        
        for section in sections {
            snapshot.appendSections([section])
            snapshot.appendItems(
                section.wrappee.items.map { CollectionViewItemWrapper(wrappee: $0) },
                toSection: section
            )
        }
        
        dataSource.apply(
            snapshot,
            animatingDifferences: animatingDifferences
        )
        
        // Calculate and set height when scrolling is disabled
        if !isScrollEnabled {
            setCollectionViewHeightToSelf()
        }
    }
    
    // MARK: Setup
    private func setupBind() {
        collectionView.rx.observe(CGSize.self, "contentSize")
            .distinctUntilChanged()
            .compactMap { $0 }
            .bind(to: _onChangeContentSize)
            .disposed(by: disposeBag)
    }
    
    // MARK: Register cell
    private func registerCell() {
        collectionView.register(
            CollectionViewItemCellContainer.self,
            forCellWithReuseIdentifier: self.itemCellIdentifier
        )
        
        // section header
        collectionView.register(
            CollectionViewResuableViewContainer.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: self.reusableViewIdentifier
        )
        
        // section footer
        collectionView.register(
            CollectionViewResuableViewContainer.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: self.reusableViewIdentifier
        )
    }
    
    // MARK: Calculate height when scroll disabled
    private func setCollectionViewHeightToSelf() {
        guard let collectionView = collectionView else { return }
        
        let totalHeight = sections.enumerated().reduce(0) { totalHeight, sectionInfo in
            let (sectionIndex, section) = sectionInfo
            let sectionLayout = section.wrappee.layout
            let sectionHeight = calculateSectionHeight(
                for: sectionLayout,
                items: section.wrappee.items,
                sectionIndex: sectionIndex
            )
            return totalHeight + sectionHeight
        }
        
        self.snp.remakeConstraints {
            $0.height.equalTo(totalHeight)
        }
        
        self.layoutIfNeeded()
    }

    private func calculateSectionHeight(
        for layout: CompositionalLayout,
        items: [any CompositionalItem],
        sectionIndex: Int
    ) -> CGFloat {
        let groupHeight = calculateGroupHeight(
            groupLayout: layout.groupLayout,
            items: items,
            sectionIndex: sectionIndex,
            scrollBehavior: layout.scrollBehavior
        )
        
        let insetHeight = layout.sectionInset.top + layout.sectionInset.bottom
        let headerHeight = layout.headerSize?.height.dimension ?? 0
        let footerHeight = layout.footerSize?.height.dimension ?? 0
        
        return groupHeight + insetHeight + headerHeight + footerHeight
    }

    private func calculateGroupHeight(
        groupLayout: CompositionalGroupLayout,
        items: [any CompositionalItem],
        sectionIndex: Int,
        scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    ) -> CGFloat {
        let itemSizes = items.indices.map { itemIndex in
            let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
            return calculateContentBasedSize(for: indexPath)
        }
        
        var totalHeight: CGFloat
        
        if scrollBehavior == .none {
            // Sum all item heights when scrolling is disabled
            totalHeight = itemSizes.reduce(0) { $0 + $1.height }
            
            // Add item spacing
            if items.count > 1 {
                totalHeight += groupLayout.itemSpacing * CGFloat(items.count - 1)
            }
        } else {
            // Use the height of the tallest item when horizontal scrolling is enabled
            totalHeight = itemSizes.map { $0.height }.max() ?? 0
        }
        
        // Add group spacing if there are multiple items and scrolling is disabled
        if scrollBehavior == .none && items.count > 1 {
            totalHeight += groupLayout.groupSpacing * CGFloat(items.count - 1)
        }
        
        return totalHeight
    }

    private func calculateContentBasedSize(for indexPath: IndexPath) -> CGSize {
        guard let section = sections[safe: indexPath.section],
              let item = section.wrappee.items[safe: indexPath.item] else {
            return .zero
        }
        
        let containerCell = CollectionViewItemCellContainer()
        let cellType = item.cellType
        let cell = cellType.init()
        containerCell.setContainedCell(cell)
        containerCell.configure(with: item)
        
        containerCell.contentView.setNeedsLayout()
        containerCell.contentView.layoutIfNeeded()
        
        let size = containerCell.contentView.systemLayoutSizeFitting(
            CGSize(
                width: collectionView.bounds.width,
                height: UIView.layoutFittingCompressedSize.height
            ),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return size
    }
}
