//
//  ViewController.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit

import DesignSystem

import RxSwift
import RxCocoa
import Then
import SnapKit

class ViewController: UIViewController {
    
    private let buittonBookButton = UIButton().then {
        $0.setTitle("Button example", for: .normal)
    }
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    private func setupHierarchy() {
        view.addSubview(buittonBookButton)
    }
    
    private func setupLayout() {
        buittonBookButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupBind() {
        buittonBookButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let vc = ButtonBookViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
}
