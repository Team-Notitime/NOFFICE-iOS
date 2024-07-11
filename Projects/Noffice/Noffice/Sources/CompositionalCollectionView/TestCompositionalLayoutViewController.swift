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

class TestCompositionalLayoutViewController: UIViewController {
    
    let button: UIButton = UIButton().then {
        $0.setTitle("아이템 추가추가!", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
    }
    let collectionView = CompositionalCollectionView()
    
    var sections: [AnyCompositionalSection] = [
        Section2(
            identifier: UUID().uuidString,
            items: [
                Item2(identifier: UUID().uuidString, value: "Item3", value2: "hihi") { _ in
                    
                },
                Item2(identifier: UUID().uuidString, value: "Item4", value2: "메롱메롱") { _ in
                    
                }
            ]
        ).asAnySection()
    ]
    
    lazy var sectionsSubject = BehaviorSubject<[AnyCompositionalSection]>(value: sections)
    
    let labelTapEvent = PublishSubject<String>()
    
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
            by: sectionsSubject.asObservable()
        )
        .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.sections += [
                    Section(
                        identifier: UUID().uuidString,
                        items: [
                            Item(identifier: UUID().uuidString, value: "Additional Item") { cell in
                                cell.button.rx.tap
                                    .subscribe(onNext: { _ in
                                        print("탭탭!q")
                                    }).disposed(by: self.disposeBag)
                            },
                            Item(identifier: UUID().uuidString, value: "Additional Item") { cell in
                                cell.button.rx.tap
                                    .subscribe(onNext: { _ in
                                        print("탭탭!w")
                                    }).disposed(by: self.disposeBag)
                            }
                        ]
                    ).asAnySection()
                ]
                
                self.sectionsSubject.onNext(self.sections)
            })
            .disposed(by: disposeBag)
    }
}

extension TestCompositionalLayoutViewController {
    struct Section: CompositionalSection {
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
        
        var items: [any CompositionalItem]
        
        var identifier: String
        
        init(identifier: String, items: [Item]) {
            self.items = items
            self.identifier = identifier
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    struct Section2: CompositionalSection {
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
        
        var items: [any CompositionalItem]
        
        var identifier: String
        
        init(identifier: String, items: [Item2]) {
            self.items = items
            self.identifier = identifier
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
//            hasher.combine(items)
        }
    }
    
    final class Item: CompositionalItem {
        let binding: (ItemCell) -> Void
        var identifier: String = UUID().uuidString
        var value: String = ""

        var reusableIdentifier: String {
            return "ItemCell"
        }
        
        let disposeBag = DisposeBag()
        
        init(identifier: String, value: String, _ binding: @escaping (ItemCell) -> Void) {
            self.identifier = identifier
            self.value = value
            self.binding = binding
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
            hasher.combine(value)
        }
        
        var cellType: TestCompositionalLayoutViewController.ItemCell.Type {
            return ItemCell.self
        }
    }
    
    final class Item2: CompositionalItem {
        let binding: (ItemCell2) -> Void
        
        var reusableIdentifier: String {
            return "ItemCell2"
        }
        
        var identifier: String = UUID().uuidString
        var value: String = ""
        var value2: String = ""
        
        init(identifier: String, value: String, value2: String, _ binding: @escaping (ItemCell2) -> Void) {
            self.identifier = identifier
            self.value = value
            self.value2 = value2
            self.binding = binding
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
            hasher.combine(value)
        }
        
        var cellType: TestCompositionalLayoutViewController.ItemCell2.Type {
            return ItemCell2.self
        }
    }
    
    final class ItemCell: UICollectionViewCell, CompositionalItemCell {
        var itemType: TestCompositionalLayoutViewController.Item.Type {
            return Item.self
        }
        
        lazy var button: UIButton = {
            let button = UIButton(configuration: .filled())
            button.setTitle("Tab me", for: .normal)
            return button
        }()
        
        lazy var label: UILabel = {
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
                make.top.left.right.equalToSuperview()
            }
            
            contentView.addSubview(button)
            
            button.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(12)
                make.left.right.equalToSuperview()
            }
        }
        
        func configure(with item: Item) {
            label.text = item.value
        }
    }
    
    final class ItemCell2: UICollectionViewCell, CompositionalItemCell {
        var itemType: TestCompositionalLayoutViewController.Item2.Type {
            return Item2.self
        }
        
        private lazy var label: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .center
            return label
        }()
        
        private lazy var label2: UILabel = {
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
                make.top.left.right.equalToSuperview()
            }
            
            contentView.addSubview(label2)
            
            label2.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(12)
                make.left.right.equalToSuperview()
            }
        }
        
        func configure(with item: Item2) {
            label.text = item.value
            label2.text = item.value2
        }
    }
}
