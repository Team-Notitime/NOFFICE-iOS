//
//  NewOrganizationImagePageViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import UIKit
import Photos

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
        
        // - Selected image
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
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            showImagePicker()
        case .denied, .restricted:
            // 권한 거부 또는 제한된 경우 알림 등을 표시할 수 있습니다.
            showPermissionDeniedAlert()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        self?.showImagePicker()
                    } else {
                        self?.showPermissionDeniedAlert()
                    }
                }
            }
        @unknown default:
            break
        }
    }
    
    private func showImagePicker() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func showPermissionDeniedAlert() {
        let alert = UIAlertController(
            title: "권한 필요",
            message: "사진 라이브러리에 접근하기 위해 권한이 필요합니다. 설정에서 권한을 허용해주세요.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
