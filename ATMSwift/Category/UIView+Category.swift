//
//  UIView+Category.swift
//  TechnicalBrocade
//
//  Created by binbin.c on 2023/9/24.
//

import Foundation
import UIKit


extension UIView{
    
    var x:CGFloat{
        get {
            return self.frame.origin.x
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var y:CGFloat{
        get {
            return self.frame.origin.y
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }

    var width:CGFloat{
        get {
            return self.frame.size.width
        }
        
        set(newValue){
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    
    var height:CGFloat{
        get {
            return self.frame.size.height
        }
        
        set(newValue){
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    
    var centerX:CGFloat{
        get {
            return self.center.x
        }
        
        set(newValue){
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var centerY:CGFloat{
        get {
            return self.center.y
        }
        
        set(newValue){
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
     var midX: CGFloat {
        get {
            return self.frame.midX
        }
    }
    
     var midY: CGFloat {
        get {
            return self.frame.midY
        }
    }
    
    
     var size: CGSize {
        get {
            return self.frame.size
        }
        set(newValue) {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
     var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set(newValue) {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
     var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
     var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
     var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width;
            self.frame = frame
        }
    }
    
     var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set(newValue) {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    
    
    var cornerRadius: CGFloat{
        get{
            return self.layer.cornerRadius
        }
        
        set(newValue){
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
  
    
    //快速创建 view
    func bb_ViewWithFrame(frame:CGRect,backgroundColor:UIColor) -> UIView{
        let customView = UIView(frame: frame)
        customView.backgroundColor = backgroundColor
        return customView
    }
    
    //.allCorners .topLeft
    func addCornerRadius(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
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
