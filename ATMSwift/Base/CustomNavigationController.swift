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
            self.view.backgroundColor = Default_BackGround_Color!
            setUpNavBarItemAppearance()
        }
    }

    extension CustomNavigationController{
        func setUpNavBarItemAppearance(){
            if #available(iOS 13.0, *) {
             let appearance = UINavigationBarAppearance()
                appearance.backgroundColor = .white
                appearance.shadowColor = .clear
                appearance.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 18, weight: .bold),.foregroundColor:UIColor.black]
                self.navigationBar.standardAppearance = appearance
               // if #available(iOS 13.0, *) {
                    self.navigationBar.scrollEdgeAppearance = appearance
                //}
            }else{
                self.navigationBar.barTintColor = .white;
            self.navigationBar.titleTextAttributes =  [.font:UIFont.systemFont(ofSize: 18, weight: .bold),.foregroundColor:UIColor.black];
                self.navigationBar.shadowImage = imageWithColor(color: .clear)
                self.navigationBar.setBackgroundImage( imageWithColor(color: .white), for: .default)
        }
        // 不透明
        self.navigationBar.isTranslucent = false;
        // navigation控件颜色
            self.navigationBar.tintColor = .black;
        }
        
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
