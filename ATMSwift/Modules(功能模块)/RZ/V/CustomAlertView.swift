//
//  CustomAlertView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/14.
//

import UIKit

class CustomAlertView: UIView {
    // 弹窗所在的window（全局唯一）
    private static var alertWindow: UIWindow?
    
    // 子视图（关闭按钮、选项按钮等）
    private let closeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "common1"), for: .normal)
        btn.tintColor = .darkGray
        return btn
    }()
    
    private let albumBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Photo Album", for: .normal)
        btn.setImage(UIImage(named: "rz31"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "rz30"), for: .normal)
        btn.setTitleColor(Default_Black0_Color!, for: .normal)
        btn.setImagePosition(.left, spacing: 5)
        return btn
    }()
    
    private let cameraBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Photograph", for: .normal)
        btn.setImage(UIImage(named: "rz32"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "rz30"), for: .normal)
        btn.setTitleColor(Default_Black0_Color!, for: .normal)
        btn.setImagePosition(.left, spacing: 5)

        return btn
    }()
    
    // 背景遮罩
    private  let maskViewv: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    // 内容容器（白色背景）
    private let contentView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rz18")
        view.clipsToBounds = true
        return view
    }()
    
    // 回调闭包
    var albumHandler: (() -> Void)?
    var cameraHandler: (() -> Void)?
    var closeHandler: (() -> Void)?
    
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI 布局
    private func setupUI() {
        // 1. 遮罩占满整个window
        addSubview(maskViewv)
        maskViewv.frame = bounds
        // 遮罩添加点击事件（点击空白处关闭）
        maskViewv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(maskTapped)))
        
        // 2. 内容视图（居中显示，宽度适配）
        addSubview(contentView)
        let contentWidth = UIScreen.main.bounds.width
        let contentHeight: CGFloat = 209
        contentView.frame = CGRect(
            x: 0,
            y: (UIScreen.main.bounds.height - contentHeight),
            width: contentWidth,
            height: contentHeight
        )
        
        // 3. 关闭按钮
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.top).offset(-15)
        }
        
        // 4. 相册按钮
        contentView.addSubview(albumBtn)
        albumBtn.frame = CGRect(x: 20, y: 40, width: contentWidth - 40, height: 50)
        
        // 5. 拍照按钮
        contentView.addSubview(cameraBtn)
        cameraBtn.frame = CGRect(x: 20, y: 110, width: contentWidth - 40, height: 50)
    }
    
    // 绑定按钮事件
    private func setupActions() {
        albumBtn.addTarget(self, action: #selector(albumTapped), for: .touchUpInside)
        cameraBtn.addTarget(self, action: #selector(cameraTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
    
    
    // MARK: - 事件处理
    @objc private func closeTapped() {
        closeHandler?()
        dismiss()
    }
    
    @objc private func maskTapped() {
        closeHandler?()
        dismiss()
    }
    
    @objc private func albumTapped() {
        albumHandler?()
        dismiss() // 可选：点击后关闭弹窗
    }
    
    @objc private func cameraTapped() {
        cameraHandler?()
        dismiss() // 可选：点击后关闭弹窗
    }
    
    
    // MARK: - 显示/隐藏弹窗
    /// 显示弹窗（在全局window上）
    static func show(
        albumHandler: (() -> Void)? = nil,
        cameraHandler: (() -> Void)? = nil,
        closeHandler: (() -> Void)? = nil
    ) -> CustomAlertView {
        // 1. 创建全局window（层级最高）
        let window = UIWindow()
        window.frame = UIScreen.main.bounds
        window.windowLevel = .alert + 1 // 确保在系统弹窗之上
        window.backgroundColor = .clear
        window.rootViewController = UIViewController() // 避免事件穿透
        window.makeKeyAndVisible()
        alertWindow = window
        
        // 2. 创建弹窗并添加到window
        let alert = CustomAlertView(frame: window.bounds)
        alert.albumHandler = albumHandler
        alert.cameraHandler = cameraHandler
        alert.closeHandler = closeHandler
        window.addSubview(alert)
        
        // 3. 添加显示动画
     //   alert.contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        alert.contentView.alpha = 0
        alert.closeButton.alpha = 0
        UIView.animate(withDuration: 0.25) {
          //  alert.contentView.transform = .identity
            alert.contentView.alpha = 1
            alert.closeButton.alpha = 1
        }
        
        return alert
    }
    
    /// 隐藏弹窗
    private func dismiss() {
        // 退出动画
        UIView.animate(withDuration: 0.25, animations: {
           // self.contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.contentView.alpha = 0
            self.closeButton.alpha = 0
            self.maskViewv.alpha = 0
        }) { _ in
            // 动画结束后销毁window
            CustomAlertView.alertWindow = nil
        }
    }
}
