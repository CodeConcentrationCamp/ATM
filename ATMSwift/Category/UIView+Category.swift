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
