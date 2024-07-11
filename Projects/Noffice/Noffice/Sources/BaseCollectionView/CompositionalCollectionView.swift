//
//  CompositionalCollectionView.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/11/24.
//

import UIKit

import RxSwift

final public class CompositionalCollectionView<Section: CollectionViewSection>: UIView, UICollectionViewDelegate {
    typealias Item = Section.Item
    
    // MARK: Public properties
    public var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var registeredCellIdentifiers: Set<String> = []
    
    // MARK: Data source
    private var sections: [Section] = [] {
        didSet {
            applySnapshot(animatingDifferences: true)
        }
    }
    
    private let disposeBag = DisposeBag()
    
    init(
        layout: UICollectionViewCompositionalLayout
    ) {
        super.init(frame: .zero)
        configure(layout: layout)
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
        by sectionsObservable: Observable<[Section]>
    ) -> Disposable {
        let sectionsDisposable = sectionsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] newSections in
                guard let self = self else { return }
                self.sections = newSections
            })
        
        return Disposables.create([sectionsDisposable])
    }
    
    private func configure(layout: UICollectionViewCompositionalLayout) {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView
        ) { [weak self] (collectionView, indexPath, item) in
            guard let self = self else { return UICollectionViewCell() }
            
            self.registerCellIfNeeded(item: item)
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: item.reusableIdentifier,
                for: indexPath
            )
            
            if var cell = cell as? Item.Cell {
                item.configureCell(cell: &cell)
            }
            
            return cell
        }
        
        applySnapshot()
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        for section in sections {
            snapshot.appendSections([section])
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    // MARK: Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension CompositionalCollectionView {
    private func registerCellIfNeeded(item: Item) {
        let reusableIdentifier = item.reusableIdentifier
        
        if !registeredCellIdentifiers.contains(reusableIdentifier) {
            collectionView.register(
                Item.Cell.self,
                forCellWithReuseIdentifier: reusableIdentifier
            )
            registeredCellIdentifiers.insert(reusableIdentifier)
        }
    }
}
