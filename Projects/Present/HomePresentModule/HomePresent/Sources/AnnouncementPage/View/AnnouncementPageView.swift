//
//  AnnouncementPageView.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/15/24.
//
import UIKit

import DesignSystem
import Assets

import RxSwift
import RxCocoa
import SnapKit
import Then

final class EmptyView: UIView {
  private let iconImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let titleLabel = UILabel().then {
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.textColor = .grey800
    $0.setTypo(.body1m)
  }
  
  private let descriptionLabel = UILabel().then {
      $0.textAlignment = .center
      $0.numberOfLines = 0
      $0.textColor = .grey500
      $0.setTypo(.body3m)
  }
  
  public init(
      icon: UIImage,
      title: String,
      message: String
  ) {
      super.init(frame: .zero)
      
      iconImageView.image = icon
      titleLabel.text = title
      descriptionLabel.text = message
    
    setupHierarchy()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setup
  func setupHierarchy() {
      addSubview(iconImageView)
      addSubview(titleLabel)
      addSubview(descriptionLabel)
  }
  
  func setupLayout() {
      iconImageView.snp.makeConstraints {
          $0.centerX.equalToSuperview()
          $0.centerY.equalToSuperview().offset(-60)
          $0.size.equalTo(113)
      }
      
      titleLabel.snp.makeConstraints {
          $0.top.equalTo(iconImageView.snp.bottom).offset(10)
          $0.centerX.equalToSuperview()
      }
      
      descriptionLabel.snp.makeConstraints {
          $0.top.equalTo(titleLabel.snp.bottom).offset(8)
          $0.centerX.equalToSuperview()
      }
  }
}

class AnnouncementPageView: BaseView {
    // MARK: UI Component
    // - Announcement collection view
    lazy var collectionView = CompositionalCollectionView()
  
    private lazy var emptyView = EmptyView(
      icon: .imgNottiBang,
      title: "참여한 그룹이 없어요",
      message: "그룹에 참여해서 공지를 확인해보세요!"
    )

    // MARK: Setup
    override func setupHierarchy() {
        addSubview(collectionView)
        addSubview(emptyView)
    }
    
    override func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // bottom margin
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 32,
            right: 0
        )
      
        emptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
  
    func showEmptyView(_ show: Bool) {
        emptyView.isHidden = !show
    }
}
