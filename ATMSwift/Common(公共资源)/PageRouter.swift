//
//  PageRouter.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import UIKit

class PageRouter: NSObject {
    
    /// 挽留弹框
    class func jumpWanLiuBox(proID:String){
        
        let cancelLogouView = CancelLogouView(frame: CGRectMake(0, 0, KScreenWidth, KScreenHeight), type: 2) { customView in
            PopupAnimator.shared.dismiss(view: customView)
        } leftHander: { customView in
            PopupAnimator.shared.dismiss(view: customView)
            // 获取当前导航控制器的所有视图控制器
            guard let  nav = CustomNavigationController.current(),
                  let vcs = nav.viewControllers as? [BaseViewController] else {
                return
            }
            // 遍历查找 ProductDetailViewController 实例
            for temp in vcs {
                if temp is ProductDetailViewController {
                    // 创建新的详情页并赋值
                    let newVC = ProductDetailViewController()
                    newVC.proID = proID
                    // 弹出当前当前页并推入新页面（无动画）
                    nav.popViewController(animated: false)
                    nav.pushViewController(newVC, animated: false)
                    return
                }
            }
        }
        PopupAnimator.shared.present(view: cancelLogouView,type: .fromCenter)
    }
    
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
    
    /// 点击点单的跳转
    class func schemeType(_ url: String, vc: UIViewController) {
        // 匹配loan://app.loangabay.com前缀的URL
        if url.contains("loan://app.loangabay.com") {
            // 跳转设置页面
            if url == "loan://app.loangabay.com/ukulelePapay" {
                if let currentNav = CustomNavigationController.current(){
                    let targetVC = SetUpViewController()
                    currentNav.pushViewController(targetVC, animated: true)
                }
            }
            
            // 跳转到首页（标签栏第0项）
            if url == "loan://app.loangabay.com/honeydewGara" {
                vc.tabBarController?.selectedIndex = 0
                vc.navigationController?.popViewController(animated: false)
                return
            }
            
            // 跳转到登录页（清除Session）
            if url == "loan://app.loangabay.com/eggplantApri" {
                ToolManager.shared.saveData("", forKey: "ATM_SessionId")
                PageRouter.changeHomeOrLoginPage()
                return
            }
            
            // 跳转产品详情页（带参数）
            if url.contains("loan://app.loangabay.com/yamXylophone") {
                let proID = url.components(separatedBy: "=").last
                if let currentNav = CustomNavigationController.current(){
                    let targetVC = ProductDetailViewController()
                    targetVC.proID = proID
                    currentNav.pushViewController(targetVC, animated: true)
                }
                return
            }
        } else {
            ToolManager.shared.jumpWebWithUrl(url: url, source: "Home")
        }
    }
    
    
    // 1. 抽取重复的 peaches 处理逻辑为单独函数（避免代码重复）
    class func handlePeaches(_ peaches: String?,_ state: String?,_ proID: String? ) {
        switch peaches {
        case "groundf":
            // 处理 groundf 的逻辑
            if state == "1"{
                if  let nav = CustomNavigationController.current(){
                    let vc = VerifyIDFinishViewController()
                    vc.productID = proID
                    nav.pushViewController(vc, animated: true)
                }
            }else{
                // /miles/comparative"
                let rzViewModel = RZViewModel()
                rzViewModel.getUserInfo(proID: proID)
                rzViewModel.upDataBlock = { state, mm in
                    if state == "success"{
                        if mm?.steeple?.vines == "0"{
                            if  let nav = CustomNavigationController.current(){
                                let vc = KYCViewController()
                                vc.productID = proID
                                nav.pushViewController(vc, animated: true)
                            }
                        }else{
                            
                            if mm?.remarked == "0"{
                                if  let nav = CustomNavigationController.current(){
                                    let vc = FaceViewController()
                                    vc.productID = proID!
                                    vc.selectTitle = (mm?.steeple?.church)!
                                    nav.pushViewController(vc, animated: true)
                                }
                            }else{
                                if  let nav = CustomNavigationController.current(){
                                    let vc = VerifyIDFinishViewController()
                                    vc.productID = proID
                                    nav.pushViewController(vc, animated: true)
                                }
                            }
                            
                        }
                    }
                    
                }
                print(1)
            }
            
        case "groundg":
            // 处理 groundg 的逻辑
            if  let nav = CustomNavigationController.current(){
                let vc = PerInfoViewController()
                vc.productID = proID
                vc.state = state
                nav.pushViewController(vc, animated: true)
            }
            print(2)
        case "groundh":
            // 处理 groundh 的逻辑
            if  let nav = CustomNavigationController.current(){
                let vc = WorkViewController()
                vc.productID = proID
                vc.state = state
                nav.pushViewController(vc, animated: true)
            }
            print(3)
        case "groundi":
            // 处理 groundi 的逻辑
            if  let nav = CustomNavigationController.current(){
                let vc = ContactViewController()
                vc.productID = proID
                vc.state = state
                nav.pushViewController(vc, animated: true)
            }
            print(4)
        case "groundj":
            // 处理 groundj 的逻辑
            if  let nav = CustomNavigationController.current(){
                let vc = BankViewController()
                vc.productID = proID
                vc.state = state
                nav.pushViewController(vc, animated: true)
            }
            print(5)
        default:
            break // 无需 return，默认不处理
        }
    }
    ///  通过proID 跳转界面
    class func jumpPage(_ proID:String?){
        if proID != nil{
            let viewModel = ProductModelView()
            viewModel.getProductDetail(proID:proID)
            viewModel.upDataBlock = { state,mm in
                if state == "success"{
                    if mm != nil{
                        if mm?.creatures?.peaches?.isEmpty == true{
                            let rzViewModel = RZViewModel()
                            rzViewModel.getOrderUrl(toward: mm?.plums?.toward)
                        }else{
                            handlePeaches(mm?.creatures?.peaches,"0",proID)
                        }
                    }
                }
            }
        }
    }
}
    
