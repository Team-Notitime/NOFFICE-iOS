//
//  CompositionalCollectionView.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/11/24.
//

import UIKit

import RxSwift

final public class CompositionalCollectionView: UIView, UICollectionViewDelegate {
//    typealias AnyCollectionViewItem = any CollectionViewItem & Hashable
    
    // MARK: Public properties
    public var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<AnyCollectionViewSection, CollectionViewItemWrapper>!
    private var registeredCellIdentifiers: Set<String> = []
    
    // MARK: Data source
    private var sections: [AnyCollectionViewSection] = [] {
        didSet {
            applySnapshot(animatingDifferences: true)
        }
    }
    
    private let disposeBag = DisposeBag()
    
    init(
//        layout: UICollectionViewCompositionalLayout
    ) {
        super.init(frame: .zero)
        configureLayout()
        configureDatasource()
        self.backgroundColor = .systemGreen
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bindSections(
        by sectionsObservable: Observable<[AnyCollectionViewSection]>
    ) -> Disposable {
        let sectionsDisposable = sectionsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] newSections in
                guard let self = self else { return }
                self.sections = newSections
            })
        
        return Disposables.create([sectionsDisposable])
    }
    
    private func configureLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            return self?.sections[sectionIndex].layout
        }
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
    }
    
    private func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<AnyCollectionViewSection, CollectionViewItemWrapper>(
            collectionView: collectionView
        ) { [weak self] (collectionView, indexPath, itemWrapper) in
            guard let self = self else { return UICollectionViewCell() }
            
            // Resigter cell identifier and container cell type
            let reusableIdentifier = CollectionViewItemCellContainer.reusableIdentifier
            self.registerCellIfNeeded(reusableIdentifier: reusableIdentifier)
            
            // Dequeue cell and cast container cell type
            guard let containerCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reusableIdentifier,
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
        
        applySnapshot()
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<AnyCollectionViewSection, CollectionViewItemWrapper>()
        for section in sections {
            snapshot.appendSections([section])
            snapshot.appendItems(
                section.items.map { CollectionViewItemWrapper(wrappee: $0) },
                toSection: section
            )
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    // MARK: Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension CompositionalCollectionView {
    private func registerCellIfNeeded(reusableIdentifier: String) {
        if !registeredCellIdentifiers.contains(reusableIdentifier) {
            collectionView.register(
                CollectionViewItemCellContainer.self,
                forCellWithReuseIdentifier: reusableIdentifier
            )
            registeredCellIdentifiers.insert(reusableIdentifier)
        }
    }
}
