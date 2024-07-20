//
//  NewOrganizationImagePageViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit

import DesignSystem

import Swinject
import RxSwift
import RxCocoa

class NewOrganizationImagePageViewController: BaseViewController<NewOrganizationImagePageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(NewOrganizationImagePageReactor.self)!
    
    // MARK: Image Picker
    private let imagePicker = UIImagePickerController()
    
    // MARK: Setup
    override func setupViewBind() {
        imagePicker.delegate = self
    }
    
    override func setupStateBind() {
        // - Next page button active state
        reactor.state.map { $0.nextPageButtonActive }
            .withUnretained(self)
            .subscribe(onNext: { owner, active in
                owner.baseView.nextPageButton.isEnabled = active
            })
            .disposed(by: self.disposeBag)
        
        // Selected image
        reactor.state.map { $0.selectedImage }
            .bind(to: baseView.imageView.rx.image)
            .disposed(by: self.disposeBag)
    }
    
    override func setupActionBind() {
        // - Select image
        baseView.imageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                 self?.presentImagePicker()
             })
            .disposed(by: self.disposeBag)
            
        // - Tap next page button
        baseView.nextPageButton
            .onTap
            .map { _ in .tapNextPageButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Private Method
    private func presentImagePicker() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension NewOrganizationImagePageViewController:
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            reactor.action.onNext(.changeSelectedImage(selectedImage))
        }
    }
    
    func imagePickerControllerDidCancel(
        _ picker: UIImagePickerController
    ) {
        picker.dismiss(animated: true, completion: nil)
    }
}
