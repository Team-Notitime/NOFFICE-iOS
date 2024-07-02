//
//  ViewController.swift
//  Noffice
//
//  Created by DOYEON LEE on 7/1/24.
//

import UIKit

import Router
import SnapKit

class ViewController: UIViewController {
    
    let button: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // 버튼 속성 설정
        button.setTitle("Go to Next Page", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // 버튼 추가 및 레이아웃 설정
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc func buttonTapped() {
        Router.shared.push(SecondViewController())
    }
}
