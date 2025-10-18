//
//  UIView+Category.swift
//  TechnicalBrocade
//
//  Created by binbin.c on 2023/9/24.
//

import Foundation
import UIKit


extension UIView{
    
    //快速创建 view
    func bb_ViewWithFrame(frame:CGRect,backgroundColor:UIColor) -> UIView{
        let customView = UIView(frame: frame)
        customView.backgroundColor = backgroundColor
        return customView
    }
}

// 寻好。 UIViewController -- UINavigationController
extension UIResponder{
    public  func findController<T: UIViewController>(ofType type: T.Type) -> T? {
          var responder: UIResponder? = self.next
          while let currentResponder = responder {
              if let targetController = currentResponder as? T {
                  return targetController
              }
              responder = currentResponder.next
          }
          return nil
      }
}

extension UIViewController {
    
    func getCurrentController() -> UIViewController! {
        return self.findControllerWithClass(UIViewController.self)
    }
    
    func getCurrentNavigation() -> UINavigationController! {
        return self.findControllerWithClass(UINavigationController.self)
    }
    
    func findControllerWithClass<T>(_ clzz: AnyClass) -> T? {
        var responder = self.next
        while(responder != nil) {
            if (responder!.isKind(of: clzz)) {
                return responder as? T
            }
            responder = responder?.next
        }
        return nil
    }
}

func doSomething() {
        // 查找 UINavigationController 类型的控制器
//        if let nav = self.findController(ofType: UINavigationController.self) {
//            print("找到导航控制器：\(nav)")
//        }
//        
//        // 查找自定义的 HomeViewController
//        if let homeVC = self.findController(ofType: HomeViewController.self) {
//            homeVC.updateData() // 调用自定义控制器的方法
//        }
    }

extension UIButton {
    /// 设置图片与文字的相对位置
    /// - Parameters:
    ///   - imagePosition: 图片位置（左/右/上/下）
    ///   - spacing: 图片与文字的间距
    func setImagePosition(_ imagePosition: UIImage.Position, spacing: CGFloat) {
        // 获取图片和文字的尺寸
        let imageWidth = imageView?.intrinsicContentSize.width ?? 0
        let imageHeight = imageView?.intrinsicContentSize.height ?? 0
        let titleWidth = titleLabel?.intrinsicContentSize.width ?? 0
        let titleHeight = titleLabel?.intrinsicContentSize.height ?? 0
        
        switch imagePosition {
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleWidth + spacing, bottom: 0, right: -(titleWidth + spacing))
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageWidth + spacing), bottom: 0, right: imageWidth + spacing)
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -(titleHeight + spacing)/2, left: 0, bottom: (titleHeight + spacing)/2, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: (imageHeight + spacing)/2, left: 0, bottom: -(imageHeight + spacing)/2, right: 0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: (titleHeight + spacing)/2, left: 0, bottom: -(titleHeight + spacing)/2, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: -(imageHeight + spacing)/2, left: 0, bottom: (imageHeight + spacing)/2, right: 0)
        }
    }
}

// 定义图片位置枚举
extension UIImage {
    enum Position {
        case left, right, top, bottom
    }
}
