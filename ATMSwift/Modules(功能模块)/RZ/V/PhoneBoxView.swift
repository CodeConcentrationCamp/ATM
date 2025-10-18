//
//  PhoneBoxView.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/15.
//

import UIKit

class PhoneBoxView: UIView {
    
    // 回调闭包
    var albumHandler: ((_ customView:PhoneBoxView) -> Void)?
    var cameraHandler: ((_ customView:PhoneBoxView) -> Void)?
    var closeHandler: ((_ customView:PhoneBoxView) -> Void)?
    
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
        btn.setTitleColor(Default_Black0_Color, for: .normal)
        btn.setImagePosition(.left, spacing: 5)
        return btn
    }()
    
    private let cameraBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Photograph", for: .normal)
        btn.setImage(UIImage(named: "rz32"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "rz30"), for: .normal)
        btn.setTitleColor(Default_Black0_Color, for: .normal)
        btn.setImagePosition(.left, spacing: 5)
        
        return btn
    }()
    
    // 内容容器（白色背景）
    private let contentView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rz18")
     //   view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    init(frame: CGRect,albumHandler: ((_ customView:PhoneBoxView) -> Void)?,
         cameraHandler: ((_ customView:PhoneBoxView) -> Void)?,closaHandler:((_ customView:PhoneBoxView) -> Void)?) {
        super.init(frame: frame)
        self.albumHandler = albumHandler
        self.cameraHandler = cameraHandler
        self.closeHandler = closaHandler
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        // 1. 内容视图（居中显示，宽度适配）
        addSubview(contentView)
        let contentWidth = UIScreen.main.bounds.width
        contentView.frame = CGRectMake(0, 50, KScreenWidth, 209)
        
        // 2. 关闭按钮
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.top).offset(-15)
        }
        
        // 3. 相册按钮
        contentView.addSubview(albumBtn)
        albumBtn.frame = CGRect(x: 20, y: 40, width: contentWidth - 40, height: 50)
        
        // 4. 拍照按钮
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
        closeHandler?(self)
    }
    
    
    @objc private func albumTapped() {
        albumHandler?(self)
    }
    
    @objc private func cameraTapped() {
        cameraHandler?(self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
