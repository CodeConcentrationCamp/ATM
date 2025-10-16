//
//  PhotoLibraryManager.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/15.
//

import UIKit
import Photos

class PhotoLibraryManager: NSObject {
    // 单例
    static let shared = PhotoLibraryManager()
    private override init() {}
    
    // 图片选择完成的回调
    private var completion: ((UIImage?) -> Void)?
    
    // 打开相册
    func openPhotoLibrary(from vc: UIViewController, completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
        
        // 检查相册权限
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    // 已授权，打开相册
                    self?.presentImagePicker(from: vc, sourceType: .photoLibrary)
                case .denied, .restricted:
                    // 未授权，提示用户去设置开启
                    self?.showPermissionAlert(from: vc)
                case .notDetermined:
                    // 首次请求权限（系统会自动弹窗）
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    // 打开相机（可选，如需拍照功能）
    func openCamera(from vc: UIViewController, completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
        
        // 检查相机权限
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            DispatchQueue.main.async {
                if granted {
                    self?.presentImagePicker(from: vc, sourceType: .camera)
                } else {
                    self?.showPermissionAlert(from: vc)
                }
            }
        }
    }
    
    // 显示图片选择器
    private func presentImagePicker(from vc: UIViewController, sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            print("不支持该来源（如模拟器无相机）")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = false // 允许编辑图片（裁剪等）
        vc.present(imagePicker, animated: true)
    }
    
    // 权限不足时显示提示弹窗
    private func showPermissionAlert(from vc: UIViewController) {
        let alert = UIAlertController(
            title: "权限不足",
            message: "请在设置中允许访问相册",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsURL)
        })
        vc.present(alert, animated: true)
    }
}

// MARK: - UIImagePickerController 代理（处理选择结果）
extension PhotoLibraryManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 选择图片完成
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 关闭选择器
        picker.dismiss(animated: true)
        
        // 获取选择的图片（editedImage是编辑后的图片，originalImage是原始图）
        let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
        
        completion?(selectedImage)
    }
    
    // 取消选择
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        completion?(nil)
    }
}
