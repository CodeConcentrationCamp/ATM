//
//  PopupAnimator.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/15.
//

import UIKit

/// 弹窗动画类型
enum PopupAnimationType {
    case fromBottom   // 从底部弹出
    case fromCenter   // 从中心放大
    case fromRight    // 从右侧滑入
}

class PopupAnimator {
    /// 单例（确保全局弹窗逻辑统一）
    static let shared = PopupAnimator()
    var customType: PopupAnimationType = .fromBottom
    private init() {}
    
    /// 弹出视图（核心方法）
    /// - Parameters:
    ///   - view: 要弹出的自定义View
    ///   - type: 动画类型
    ///   - maskClosure: 点击遮罩的回调（默认点击遮罩关闭弹窗）
    func present(view: UIView,
                 type: PopupAnimationType = .fromBottom,
                 maskClosure: (() -> Void)? = nil) {
        
        customType = type
        // 1. 创建遮罩（半透明黑色）
        let maskView = UIView()
        maskView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        maskView.alpha = 0
        maskView.tag = 999 // 用于后续移除
        maskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(maskTapped(_:))))
        
        // 2. 获取主窗口并添加视图
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        window.addSubview(maskView)
        window.addSubview(view)
        maskView.frame = window.bounds
        
        // 3. 根据动画类型设置初始状态
        setupInitialState(for: view, type: type, in: window)
        
        // 4. 执行动画
        UIView.animate(withDuration: 0.3, animations: {
            maskView.alpha = 1
            self.setupFinalState(for: view, type: type)
        })
        
        // 存储遮罩回调
        if let closure = maskClosure {
            maskView.accessibilityLabel = "custom_closure"
            objc_setAssociatedObject(maskView, &AssocKeys.maskClosure, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    /// 关闭弹窗
    func dismiss(view: UIView) {
        // 1. 找到遮罩并执行消失动画
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
              let maskView = window.viewWithTag(999) else { return }
        
        // 2. 根据当前视图状态判断动画类型（反推初始动画）
        //let type = inferAnimationType(for: view)
        
        // 3. 执行消失动画
        UIView.animate(withDuration: 0.3, animations: {
            maskView.alpha = 0
            self.setupDismissState(for: view, type: self.customType)
        }) { _ in
            view.removeFromSuperview()
            maskView.removeFromSuperview()
        }
    }
}

// MARK: - 动画状态设置
private extension PopupAnimator {
    /// 设置动画初始状态（未显示时）
    func setupInitialState(for view: UIView, type: PopupAnimationType, in window: UIWindow) {
        switch type {
        case .fromBottom:
            // 初始位置：屏幕底部外面
            view.frame = CGRect(
                x: 0,
                y: window.bounds.height,
                width: window.bounds.width,
                height: view.bounds.height
            )
        case .fromCenter:
            // 初始状态：中心缩小且透明
            view.center = window.center
            view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            view.alpha = 0
        case .fromRight:
            // 初始位置：屏幕右侧外面
            view.frame = CGRect(
                x: window.bounds.width,
                y: 0,
                width: view.bounds.width,
                height: window.bounds.height
            )
        }
    }
    
    /// 设置动画最终状态（显示完成时）
    func setupFinalState(for view: UIView, type: PopupAnimationType) {
        switch type {
        case .fromBottom:
            // 最终位置：底部对齐，顶部露出
            view.frame.origin.y = UIScreen.main.bounds.height - view.bounds.height
        case .fromCenter:
            // 最终状态：正常大小且不透明
            view.transform = .identity
            view.alpha = 1
        case .fromRight:
            // 最终位置：右侧对齐，左侧露出
            view.frame.origin.x = UIScreen.main.bounds.width - view.bounds.width
        }
    }
    
    /// 设置消失动画状态
    func setupDismissState(for view: UIView, type: PopupAnimationType) {
        switch type {
        case .fromBottom:
            view.frame.origin.y = UIScreen.main.bounds.height
        case .fromCenter:
            view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            view.alpha = 0
        case .fromRight:
            view.frame.origin.x = UIScreen.main.bounds.width
        }
    }
    
    /// 推断当前视图的动画类型（用于关闭时匹配动画）
    func inferAnimationType(for view: UIView) -> PopupAnimationType {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        if view.frame.origin.y >= screenHeight - view.bounds.height + 10 {
            return .fromBottom
        } else if view.frame.origin.x >= screenWidth - view.bounds.width + 10 {
            return .fromRight
        } else {
            return .fromCenter
        }
    }
}

// MARK: - 事件处理
private extension PopupAnimator {
    /// 点击遮罩
    @objc func maskTapped(_ gesture: UITapGestureRecognizer) {
        guard let maskView = gesture.view else { return }
        // 1. 优先执行自定义回调
        if let closure = objc_getAssociatedObject(maskView, &AssocKeys.maskClosure) as? () -> Void {
            closure()
        } else {
            // 2. 默认逻辑：关闭最上层的弹窗
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
                  let popupView = window.subviews.last(where: { $0.tag != 999 }) else { return }
            dismiss(view: popupView)
        }
    }
}

// MARK: - 关联对象（存储回调）
private struct AssocKeys {
    static var maskClosure = "maskClosure"
}



