//
//  NewOrganizationImagePageViewController.swift
//  OrganizationPresent
//
//  Created by DOYEON LEE on 7/19/24.
//

import DesignSystem
import Photos
import ProgressHUD
import RxCocoa
import RxSwift
import Swinject
import UIKit

// MARK: - NewOrganizationImagePageViewController
class NewOrganizationImagePageViewController: BaseViewController<NewOrganizationImagePageView> {
    // MARK: Reactor
    private let reactor = Container.shared.resolve(NewOrganizationImagePageReactor.self)!

    // MARK: Image Picker
    private let imagePicker = UIImagePickerController()

    // MARK: Setup
    override func setupViewBind() {
        imagePicker.delegate = self

        // - Select image
        baseView.imageView.rx.tapGesture()
            .when(.recognized)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                self?.showImageSelectionSheet()
            })
            .disposed(by: self.disposeBag)
    }

    override func setupStateBind() {
        // - Next page button active state
        reactor.state.map { $0.nextPageButtonActive }
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { owner, active in
                owner.baseView.nextPageButton.isEnabled = active
            })
            .disposed(by: self.disposeBag)

        // - Selected image
        reactor.state.map { $0.selectedImage?.data }
            .map { imageData -> UIImage? in
                guard let data = imageData else {
                    return nil
                }
                return UIImage(data: data)
            }
            .bind(to: baseView.imageView.rx.image)
            .disposed(by: self.disposeBag)
    }

    override func setupActionBind() {
        // - Tap next page button
        baseView.nextPageButton
            .onTap
            .map { _ in .tapNextPageButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }

    // MARK: Private Method

    private func showImageSelectionSheet() {
        let alert = UIAlertController(title: "이미지 선택", message: nil, preferredStyle: .actionSheet)

        // FIXME: 사진 찍기 or 취소 후 다시 돌아올 때 빈 화면인 이슈 있음
//        alert.addAction(UIAlertAction(title: "카메라", style: .default) { [weak self] _ in
//            self?.presentCamera()
//        })

        alert.addAction(UIAlertAction(title: "앨범", style: .default) { [weak self] _ in
            self?.presentImagePicker()
        })

        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            self?.removeSelectedImage()
        })

        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }

    private func presentCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alert = UIAlertController(
                title: "카메라 사용 불가",
                message: "카메라를 사용할 수 없습니다.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

    private func presentImagePicker() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            showImagePicker()

        case .denied,
             .restricted:
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

    private func removeSelectedImage() {
        reactor.action.onNext(.deleteSelectedImage)
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

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension NewOrganizationImagePageViewController:
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage,
           let imageUrl = info[.imageURL] as? URL {
            reactor.action.onNext(
                .changeSelectedImage(
                    .init(
                        url: imageUrl,
                        data: selectedImage.jpegData(
                            compressionQuality: 1.0
                        ) ?? Data()
                    )
                )
            )
        }
    }

    func imagePickerControllerDidCancel(
        _ picker: UIImagePickerController
    ) {
        picker.dismiss(animated: true, completion: nil)
    }
}
