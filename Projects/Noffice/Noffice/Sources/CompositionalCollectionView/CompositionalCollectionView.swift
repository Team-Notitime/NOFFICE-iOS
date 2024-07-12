//
//  CompositionalCollectionView.swift
//
//  Created by DOYEON LEE on 7/11/24.
//
//  Referenced by Mumu
//

import UIKit

import RxSwift

final public class CompositionalCollectionView<Section: CompositionalSection>: UIView, UICollectionViewDelegate {
    // MARK: Identifier
    private let itemCellIdentifier = CollectionViewItemCellContainer.reusableIdentifier
    private let reusableViewIdentifier = CollectionViewResuableViewContainer.reusableIdentifier
    
    // MARK: CollectionView & DataSource
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, CollectionViewItemWrapper>!
    
    // MARK: Injected data
    private var sections: [Section] = [] {
        didSet {
            applySnapshot(animatingDifferences: true)
        }
    }
    
    // MARK: Disposebag
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    init() {
        super.init(frame: .zero)
        configureCompositionalLayout()
        configureDatasource()
        configureCollectionView()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public interface for RxSwift
    public func bindSections(
        to sectionsObservable: Observable<[Section]>
    ) -> Disposable {
        let sectionsDisposable = sectionsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] newSections in
                guard let self = self else { return }
                self.sections = newSections
            })
        
        return Disposables.create([sectionsDisposable])
    }
    
    // MARK: Configure collection view
    /// Set the compositional layout of collection view using the sections
    private func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            return self?.sections[sectionIndex].layout.makeSectionLayout()
        }
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
    }
    
    /// Set the diffable datasource and cell dequeue logic
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CollectionViewItemWrapper>(
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
            containerCell.configure(with: itemWrapper.wrappee) // include bind
            
            return containerCell
        }
        
        // Set the supplementary view provider
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
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
                let headerType = section.headerType
                let view = headerType.init()
                
                headerView.setContainedView(view)
                headerView.configure(with: section, type: .header)
                
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
                let footerType = section.footerType
                let view = footerType.init()
                
                footerView.setContainedView(view)
                footerView.configure(with: section, type: .footer)
                
                return footerView
            }
            
            return nil
        }
        
        applySnapshot()
    }
    
    /// Set the collection view layout (relative to the parent view) and delegate
    private func configureCollectionView() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
    }
    
    // MARK: Snapshot
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CollectionViewItemWrapper>()
        
        for section in sections {
            snapshot.appendSections([section])
            snapshot.appendItems(
                section.items.map { CollectionViewItemWrapper(wrappee: $0) },
                toSection: section
            )
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    // MARK: Collection view Delegate
    /// 필요한가?
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension CompositionalCollectionView {
    private func registerCell(){
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
            withReuseIdentifier:self.reusableViewIdentifier
        )
    }
}
