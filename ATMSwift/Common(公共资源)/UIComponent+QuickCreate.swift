//
//  UIComponent+QuickCreate.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/17.
//

import UIKit

// MARK: - 快速创建 UIImageView
extension UIImageView {
    static func quickCreate(
        frame: CGRect,
        bgImageName: String = ""
    ) -> UIImageView{
        let imageView = UIImageView(frame: frame)
        imageView.image = UIImage(named: bgImageName)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}

// MARK: - 快速创建 UIView
extension UIView {
    // MARK: - 快速创建 UIView
    static func quickCreate(
        frame: CGRect,
        bgColor: UIColor = .white,
        
    ) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = bgColor
        return view
    }
    
    /// 链式添加子视图
    @discardableResult
    func addSubviews(_ subviews: UIView...) -> Self {
        subviews.forEach { addSubview($0) }
        return self
    }
    
    // MARK: - 属性
    var x: CGFloat{
        get {
            return self.frame.origin.x
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var y: CGFloat{
        get {
            return self.frame.origin.y
        }
        
        set(newValue){
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var width: CGFloat{
        get {
            return self.frame.size.width
        }
        
        set(newValue){
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    var height: CGFloat{
        get {
            return self.frame.size.height
        }
        
        set(newValue){
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    var centerX: CGFloat{
        get {
            return self.center.x
        }
        
        set(newValue){
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    var centerY: CGFloat{
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
    
    //.allCorners .topLeft
    func addCornerRadius(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
}

// MARK: - 快速创建 UILabel
extension UILabel {
    /// 快速创建 UILabel
    /// - Parameters:
    ///   - text: 文本（默认空）
    ///   - font: 字体（默认14号常规）
    ///   - textColor: 文字颜色（默认黑色）
    ///   - alignment: 对齐方式（默认左对齐）
    ///   - numberOfLines: 行数（默认1行）

    
    static func quickCreate(
        frame: CGRect = .zero,
        text: String,
        textColor: UIColor,
        fontSize: CGFloat,
        textAlignment: NSTextAlignment
    ) -> UILabel {
        let label = UILabel(frame: frame)
        label.text = text
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = textAlignment
        label.numberOfLines = 1 // 默认单行
        return label
    }

    
    /// 链式设置字体（支持动态调整）
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    /// 链式设置文本
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
}

// MARK: - 快速创建 UIButton
extension UIButton {
    /// 快速创建 UIButton（文字按钮）
    /// - Parameters:
    ///   - title: 标题（默认空）
    ///   - titleColor: 标题颜色（默认蓝色）
    ///   - font: 字体（默认14号常规）
    ///   - bgColor: 背景色（默认透明）
    static func quickCreate(
        title: String? = nil,
        titleColor: UIColor = .systemBlue,
        font: UIFont = .systemFont(ofSize: 14),
        bgColor: UIColor = .clear
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = bgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    /// 快速创建 UIButton（图片按钮）
    /// - Parameters:
    ///   - image: 图片
    ///   - bgColor: 背景色（默认透明）
    static func quickCreate(
        image: UIImage?,
        bgColor: UIColor = .clear
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.backgroundColor = bgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    /// 链式设置标题
    @discardableResult
    func title(_ title: String?, for state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }
    
    /// 链式添加点击事件
    @discardableResult
    func addAction(_ action: @escaping () -> Void, for controlEvents: UIControl.Event = .touchUpInside) -> Self {
        addTarget(self, action: #selector(buttonActionHandler(_:)), for: controlEvents)
        // 用关联对象存储闭包
        objc_setAssociatedObject(self, &buttonActionKey, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        return self
    }
    
    // 闭包触发方法
    @objc private func buttonActionHandler(_ sender: UIButton) {
        if let action = objc_getAssociatedObject(self, &buttonActionKey) as? () -> Void {
            action()
        }
    }
}



// 关联对象的key（用于存储按钮点击闭包）
private var buttonActionKey: Void?
