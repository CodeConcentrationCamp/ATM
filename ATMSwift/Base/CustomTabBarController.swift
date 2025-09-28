//
//  CustomTabBarController.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/21.
//

import UIKit

class CustomTabBarModel: NSObject {
    var title:NSString?
    var infoImage:NSString?
    var infoSelectImage:NSString?
    var viewController:UIViewController?
    
    init(title: NSString? = nil, infoImage: NSString? = nil, infoSelectImage: NSString? = nil, viewController: UIViewController? = nil) {
        self.title = title
        self.infoImage = infoImage
        self.infoSelectImage = infoSelectImage
        self.viewController = viewController
    }
}

class CustomTabBarController: UITabBarController {

  
    var aItemArray:[CustomTabBarModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Default_BackGround_Color!
        setUpChildViewController()
        setUpTabBar()
        setUpTabBarItemAppearance()
        
        let tabBar = CustomTabBar(frame: self.tabBar.frame)
        self.setValue(tabBar, forKey: "tabBar")
        
    }

}


extension CustomTabBarController{
    func setUpChildViewController(){
        let homeModel = CustomTabBarModel.init(title: "",infoImage: "sy_tab_h_ic_w", infoSelectImage: "sy_tab_h_ic", viewController: HomeViewController())
        let orderModek = CustomTabBarModel.init(title: "",infoImage: "sy_tab_o_ic_w", infoSelectImage: "sy_tab_o_ic", viewController: OrderViewController())
        let mineModel = CustomTabBarModel.init(title: "",infoImage: "sy_tab_m_ic_w", infoSelectImage: "sy_tab_m_ic", viewController: MineViewController())
        aItemArray = [homeModel,orderModek,mineModel]
    }
    
    
    func setUpTabBar(){
        for tabBarModel in aItemArray {
            tabBarModel.viewController?.tabBarItem.image = UIImage.init(named:tabBarModel.infoImage! as String)?.withRenderingMode(.alwaysOriginal)
            tabBarModel.viewController?.tabBarItem.selectedImage = UIImage(named: tabBarModel.infoSelectImage! as String)?.withRenderingMode(.alwaysOriginal)
            let nav = CustomNavigationController(rootViewController: tabBarModel.viewController!)
            self.addChild(nav)
        }
    }
    

    func setUpTabBarItemAppearance(){
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .white
            //TabBar顶部线条
            appearance.shadowColor = .clear
            appearance.backgroundEffect = nil
    
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.gray]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.black]
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        } else {}
    }

}
