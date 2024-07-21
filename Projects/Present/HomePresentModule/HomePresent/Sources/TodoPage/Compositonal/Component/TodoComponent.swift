//
//  TodoComponent.swift
//  HomePresent
//
//  Created by DOYEON LEE on 7/21/24.
//

import UIKit

import DesignSystem

import RxSwift
import RxCocoa
import SnapKit
import Then

struct TodoComponent: Component {
    let identifier: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    func prepareForReuse(content: HomeFeedView) {
        content.aLabel.numberOfLines = 1
    }
}

extension TodoComponent {
    typealias ContentType = HomeFeedView

    func render(content: ContentType, context: Self, disposeBag: inout DisposeBag) {
        content.aLabel.text = """
        kadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakld
        """
        
        content.aButton.setTitle("눌러랏", for: .normal)
        content.aButton.setTitleColor(.white, for: .normal)
        
        content.aButton.rx.tap
            .subscribe(onNext: { [weak content] _ in
                guard let content = content else { return }
                content.aButton.isSelected.toggle()
                content.aLabel.numberOfLines = content.aButton.isSelected ? 0 : 1
//                content.actionEventEmitter.onNext(AssistantCommonErrorAction(identifier: context.identifier))
            })
            .disposed(by: disposeBag)
    }
}

final class HomeFeedView: BaseView, ActionEventEmitable {
    var actionEventEmitter = PublishSubject<ActionEventItem>()
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "yellowSky")
    }
    
    let aLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    let aButton = UIButton().then {
        $0.backgroundColor = .systemBlue
    }
    
    override func setupHierarchy() {
        addSubview(imageView)
        addSubview(aLabel)
        addSubview(aButton)
    }
    
    override func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(320)
            make.bottom.equalTo(aLabel.snp.top).offset(-16)
        }
        
        aLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(aButton.snp.top).offset(-16)
        }
        
        aButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
