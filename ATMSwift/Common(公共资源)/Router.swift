//
//  Router.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/28.
//

import UIKit

/// 页面跳转管理工具（单例模式）
final class Router {
    // 单例实例
    static let shared = Router()
    
    // 私有初始化，防止外部创建
    private init() {}
    
    // MARK: - 核心方法：获取当前顶层控制器
    private func getTopViewController() -> UIViewController? {
        // 1. 获取当前活跃的窗口
        guard let window = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first(where: { $0.isKeyWindow }) else {
            print("⚠️ 未找到keyWindow")
            return nil
        }
        
        // 2. 从根控制器开始查找顶层控制器
        var topVC = window.rootViewController
        
        // 递归查找：处理导航栏、标签栏、模态弹窗等情况
        while true {
            if let nav = topVC as? UINavigationController {
                // 如果是导航控制器，取其顶层控制器
                topVC = nav.topViewController
            } else if let tab = topVC as? UITabBarController {
                // 如果是标签控制器，取其选中的控制器
                topVC = tab.selectedViewController
            } else if let presented = topVC?.presentedViewController {
                // 如果有模态弹出的控制器，继续查找
                topVC = presented
            } else {
                // 没有更上层的控制器了，返回当前
                break
            }
        }
        
        return topVC
    }
    
    // MARK: - 导航栏跳转（Push）
    /// 从当前导航栈 push 到目标控制器
    func push(_ vc: UIViewController, animated: Bool = true) {
        guard let topVC = getTopViewController() else { return }
        
        // 查找当前导航控制器
        if let nav = topVC.navigationController {
            nav.pushViewController(vc, animated: animated)
        } else {
            // 如果当前控制器不在导航栈中，先包装一个导航控制器
            let nav = UINavigationController(rootViewController: topVC)
            UIApplication.shared.keyWindow?.rootViewController = nav
            nav.pushViewController(vc, animated: animated)
        }
    }
    
    // MARK: - 模态跳转（Present）
    /// 模态弹出目标控制器
    func present(_ vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let topVC = getTopViewController() else { return }
        
        // 避免重复弹出同一个控制器
        if topVC.presentedViewController === vc { return }
        
        // 通常模态弹出的控制器会包装导航栏，方便返回
        let nav = UINavigationController(rootViewController: vc)
        topVC.present(nav, animated: animated, completion: completion)
    }
    
    // MARK: - 返回操作
    /// 返回上一级控制器
    func pop(animated: Bool = true) {
        guard let nav = getTopViewController()?.navigationController else {
            print("⚠️ 没有导航控制器，无法pop")
            return
        }
        nav.popViewController(animated: animated)
    }
    
    /// 返回根控制器
    func popToRoot(animated: Bool = true) {
        guard let nav = getTopViewController()?.navigationController else {
            print("⚠️ 没有导航控制器，无法返回根控制器")
            return
        }
        nav.popToRootViewController(animated: animated)
    }
    
    /// 关闭当前模态控制器
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let topVC = getTopViewController() else { return }
        topVC.dismiss(animated: animated, completion: completion)
    }
}
