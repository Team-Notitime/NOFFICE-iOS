//
//  SecondViewController.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/2/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class SecondViewController: UIViewController {
    
    let button: UIButton = UIButton().then {
        $0.setTitle("아이템 추가추가!", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
    }
    let collectionView = CompositionalCollectionView()
    
    var sections: [AnyCollectionViewSection] = [
        Section(
            identifier: UUID().uuidString,
            items: [
                Item(identifier: UUID().uuidString, value: "Item1"),
                Item(identifier: UUID().uuidString, value: "Item2")
            ]
        ).asAnySection(),
        Section2(
            identifier: UUID().uuidString,
            items: [
                Item2(identifier: UUID().uuidString, value: "Item3"),
                Item2(identifier: UUID().uuidString, value: "Item4")
            ]
        ).asAnySection()
    ]
    
    lazy var sectionsSubject = BehaviorSubject<[AnyCollectionViewSection]>(value: sections)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hierarchy
        view.addSubview(button)
        view.addSubview(collectionView)
        
        // layout
        button.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        // bind
        collectionView.bindSections(
            by: sectionsSubject.debug().asObservable()
        )
        .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.sections += [
                    Section(
                        identifier: UUID().uuidString,
                        items: [
                            Item(identifier: UUID().uuidString, value: "Additional Item"),
                            Item(identifier: UUID().uuidString, value: "Additional Item")
                        ]
                    ).asAnySection()
                ]
                
                self.sectionsSubject.onNext(self.sections)
            })
            .disposed(by: disposeBag)
    }
}

extension SecondViewController {
    struct Section: CollectionViewSection {
        var layout: NSCollectionLayoutSection {
            let itemSize1 = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.7),
                heightDimension: .absolute(100)
            )
            let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
            
            let itemSize2 = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.3),
                heightDimension: .absolute(100)
            )
            let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(100)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item1, item2]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        var items: [any CollectionViewItem]
        
        var identifier: String
        var reusableIdentifier: String {
            return "Section"
        }
        
        init(identifier: String, items: [Item]) {
            self.items = items
            self.identifier = identifier
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
//            hasher.combine(items)
        }
    }
    
    struct Section2: CollectionViewSection {
        var layout: NSCollectionLayoutSection {
            let itemSize1 = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.3),
                heightDimension: .fractionalHeight(1.0)
            )
            let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
            
            let itemSize2 = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.7),
                heightDimension: .absolute(100)
            )
            let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(100)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item1, item2]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        var items: [any CollectionViewItem]
        
        var identifier: String
        var reusableIdentifier: String {
            return "Section"
        }
        
        init(identifier: String, items: [Item2]) {
            self.items = items
            self.identifier = identifier
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
//            hasher.combine(items)
        }
    }
    
    final class Item: CollectionViewItem {
        typealias Cell = ItemCell
        
        var identifier: String = UUID().uuidString
        var value: String = ""

        var reusableIdentifier: String {
            return "ItemCell"
        }
        
        init(identifier: String, value: String) {
            self.identifier = identifier
            self.value = value
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
            hasher.combine(value)
        }
        
        var cellType: SecondViewController.ItemCell.Type {
            return ItemCell.self
        }
        
    }
    
    final class Item2: CollectionViewItem {
        typealias Cell = ItemCell2
        
        var identifier: String = UUID().uuidString
        var value: String = ""

        var reusableIdentifier: String {
            return "ItemCell"
        }
        
        init(identifier: String, value: String) {
            self.identifier = identifier
            self.value = value
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
            hasher.combine(value)
        }
        
        var cellType: SecondViewController.ItemCell2.Type {
            return ItemCell2.self
        }
    }
    
    final class ItemCell: UICollectionViewCell, CollectionViewItemCell {
        private lazy var label: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .center
            return label
        }()
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        private func setup() {
            self.contentView.backgroundColor = .gray
            contentView.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(8)
            }
        }
        
        func configure(with item: Item) {
            label.text = item.value
        }
    }
    
    final class ItemCell2: UICollectionViewCell, CollectionViewItemCell {
        private lazy var label: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .center
            return label
        }()
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        private func setup() {
            self.contentView.backgroundColor = .gray
            contentView.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(8)
            }
        }
        
        func configure(with item: Item2) {
            label.text = item.value
        }
    }
}
