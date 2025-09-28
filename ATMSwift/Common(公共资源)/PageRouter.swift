//
//  PageRouter.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import UIKit

class PageRouter: NSObject {
    /// 切换主页或登录页面
    class func changeHomeOrLoginPage() {
        // 获取本地存储的sessionId
        let sessionId = ToolManager.shared.getData(forKey: "ATM_SessionId") as! String?
        
        // 获取AppDelegate实例
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if ((sessionId?.isEmpty) == false) {
            // 有会话ID，显示主页
            delegate.window?.rootViewController = CustomTabBarController()
        } else {
            // 无会话ID，清除相关本地数据并显示登录页
            ToolManager.shared.saveData("", forKey: "ATM_SessionId")
            
            let loginVC = LoginViewController()
            let navVC = UINavigationController(rootViewController: loginVC)
            delegate.window?.rootViewController = navVC
        }
        
        // 确保窗口可见
        delegate.window?.makeKeyAndVisible()
    }
}
