//
//  WithdrawView.swift
//  MypagePresent
//
//  Created by HUNHEE LEE on 17.02.2025.
//

import DesignSystem
import UIKit
import SwiftUICore
import MainEntity

public class WithdrawView: BaseView {
  lazy var navigationBar = NofficeNavigationBar()
  
  let titleBox: UIView = UIView()
  let titleLabel: UILabel = UILabel().then {
    $0.text = "회원 탈퇴"
    $0.textColor = .green500
    $0.setTypo(.body1b)
  }
  
  let subtitleLabel: UILabel = UILabel().then {
    $0.text = "그동안 즐거웠어요!\n다시 만나길 기대할게요"
    $0.numberOfLines = 0
    $0.textColor = .grey800
    $0.setTypo(.heading3)
  }
  
  let nottiImage: UIImageView = UIImageView().then {
    $0.image = UIImage.imgNottiMessage
    $0.contentMode = .scaleAspectFit
  }
  
  lazy var withdrawNoticeCard = BaseCard(
    contentsBuilder: {
      [
        BaseVStack(spacing: 18) {
          [
            UILabel().then {
              $0.text = "회원 탈퇴 시 아래의 정보가 삭제돼요!"
              $0.setTypo(.body1b)
              $0.textColor = .grey800
            },
            BaseVStack {
              [
                UILabel().then {
                  $0.text = "· 회원 ID"
                  $0.setTypo(.body2m)
                  $0.textColor = .grey600
                },
                UILabel().then {
                  $0.text = "· 회원님의 활동 이력, 개인정보 및 설정"
                  $0.setTypo(.body2m)
                  $0.textColor = .grey600
                },
                UILabel().then {
                  $0.text = "· 연결된 소셜 계정 정보"
                  $0.setTypo(.body2m)
                  $0.textColor = .grey600
                },
              ]
            }
          ]
        }
      ]
    }
  ).then {
    $0.styled(variant: .translucent, color: .background, padding: .large)
  }
  
  lazy var withdrawTermoptionCard = BaseCard(
    contentsBuilder: {
      [
        BaseVStack(spacing: 0) {
          [
            BaseToggleButton<TermOption>(
              option: .init(text: "안내 사항을 확인하고 회원 탈퇴에 동의합니다."),
              itemBuilder: { option in
                return [
                  UILabel().then {
                    $0.text = option.text
                    $0.setTypo(.body2m)
                    $0.textColor = .grey800
                  }
                ]
              }
            )
            .then { $0.styled(shape: .circle) }
          ]
        }
      ]
    }
  ).then {
    $0.styled(variant: .translucent, color: .background, padding: .large)
  }
  
  public override func setupHierarchy() {
    addSubview(navigationBar)
    addSubview(titleBox)
    addSubview(withdrawNoticeCard)
    addSubview(withdrawTermoptionCard)
    
    titleBox.addSubview(titleLabel)
    titleBox.addSubview(subtitleLabel)
    titleBox.addSubview(nottiImage)
  }
  
  public override func setupLayout() {
    navigationBar.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide)
      $0.left.right.equalToSuperview()
    }
    
    titleBox.snp.makeConstraints {
      $0.top.equalTo(navigationBar.snp.bottom).offset(18)
      $0.horizontalEdges.equalToSuperview().inset(20)
      $0.height.equalTo(353)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview().offset(16)
    }
    
    subtitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(4)
      $0.leading.equalTo(titleLabel)
    }
    
    nottiImage.snp.makeConstraints {
      $0.top.equalTo(subtitleLabel.snp.bottom).offset(89)
      $0.leading.equalToSuperview().offset(71)
    }
    
    withdrawNoticeCard.snp.makeConstraints {
      $0.top.equalTo(titleBox.snp.bottom).offset(18)
      $0.horizontalEdges.equalTo(titleBox)
    }
    
    withdrawTermoptionCard.snp.makeConstraints {
      $0.top.equalTo(withdrawNoticeCard.snp.bottom).offset(18)
      $0.horizontalEdges.equalTo(titleBox)
    }
  }
}
