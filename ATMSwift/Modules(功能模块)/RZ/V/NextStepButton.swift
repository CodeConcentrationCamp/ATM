//
//  NextStepButton.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/2.
//

import UIKit

class NextStepButton: UIButton {
    // 定义点击回调的闭包类型
    typealias ClickHandler = () -> Void
    
    private var clickHandler: ClickHandler?
    
    // 初始化方法，可设置按钮的样式等
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        // 设置按钮的背景颜色、文字颜色、字体等样式
        setBackgroundImage(UIImage(named: "pro4"), for: .normal)
        setTitleColor(.white, for: .normal)
        setImage(UIImage(named: "rz17"), for: .normal)
        // 添加点击事件
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    // 提供给外部设置点击回调的方法
    func setClickHandler(_ handler: @escaping ClickHandler) {
        clickHandler = handler
    }
    
    @objc private func buttonClicked() {
        // 触发回调
        clickHandler?()
    }
}
