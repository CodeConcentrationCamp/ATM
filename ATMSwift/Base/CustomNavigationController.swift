//
//  CustomNavigationController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/21.
//

import UIKit

class CustomNavigationController: UINavigationController {

        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = Default_BackGround_Color
            setUpNavBarItemAppearance(color: Default_BackGround_Color)
        }
    
    
    func setUpNavBarItemAppearance(color:UIColor){
        
        if #available(iOS 15.0, *) {
         let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = color
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 18, weight: .bold),.foregroundColor:UIColor.black]
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = appearance
            
        }else{
            self.navigationBar.barTintColor = .white;
            self.navigationBar.titleTextAttributes =  [.font:UIFont.systemFont(ofSize: 18, weight: .bold),.foregroundColor:UIColor.black];
            self.navigationBar.shadowImage = imageWithColor(color: .clear)
            self.navigationBar.setBackgroundImage( imageWithColor(color: color), for: .default)
        }
    
    }
    }

    extension CustomNavigationController{

        func imageWithColor(color:UIColor) -> UIImage
       {
               let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
               UIGraphicsBeginImageContext(rect.size)
               let context:CGContext = UIGraphicsGetCurrentContext()!
           context.setFillColor(color.cgColor);
           context.fill(rect);
               let image = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()
               
           return image!
       }
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool)
        {
            if children.count > 0 {
                viewController.hidesBottomBarWhenPushed = true
            }
            super.pushViewController(viewController, animated: animated)
        }
    }


extension CustomNavigationController {
    /// 全局获取当前活跃的导航控制器
    static func current() -> UINavigationController? {
        // 1. 获取当前活跃的窗口
        guard let window = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first(where: { $0.isKeyWindow }) else {
            return nil
        }
        
        // 2. 从根控制器开始查找导航控制器
        return findNavigationController(from: window.rootViewController)
    }
    
    /// 递归查找导航控制器
    private static func findNavigationController(from vc: UIViewController?) -> UINavigationController? {
        guard let vc = vc else { return nil }
        
        // 如果当前控制器是导航控制器，直接返回
        if let nav = vc as? UINavigationController {
            return nav
        }
        
        // 如果是标签栏控制器，查找其选中的子控制器
        if let tab = vc as? UITabBarController {
            return findNavigationController(from: tab.selectedViewController)
        }
        
        // 如果有模态弹出的控制器，查找模态控制器
        if let presented = vc.presentedViewController {
            return findNavigationController(from: presented)
        }
        
        // 递归查找子控制器（适用于容器控制器）
        for child in vc.children {
            if let nav = findNavigationController(from: child) {
                return nav
            }
        }
        
        return nil
    }
}



extension CustomNavigationController {
    /// 通过响应链全局获取导航控制器
    static func global() -> CustomNavigationController? {
        var responder: UIResponder? = UIApplication.shared
        while let currentResponder = responder {
            if let nav = currentResponder as? CustomNavigationController {
                return nav
            }
            responder = currentResponder.next
        }
        return nil
    }
}


extension CustomNavigationController{
//    // 方法1：通过窗口根控制器查找（更可靠）
//    if let currentNav = UINavigationController.current() {
//        // 执行导航操作，如 push 新页面
//        let vc = UIViewController()
//        currentNav.pushViewController(vc, animated: true)
//    }
//
//    // 方法2：通过响应链查找
//    if let globalNav = UINavigationController.global() {
//        print("找到全局导航控制器：\(globalNav)")
//    }
}
