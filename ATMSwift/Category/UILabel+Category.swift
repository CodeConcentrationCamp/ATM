//
//  UILabel+Category.swift
//  TechnicalBrocade
//
//  Created by binbin.c on 2023/9/24.
//

import Foundation
import UIKit


extension UILabel{
    
    //初始化
    func bb_LabelWithFrame(frame: CGRect, text: String, textColor: UIColor, fontSize: CGFloat, textAlignment: NSTextAlignment) -> UILabel {
        let customLabel = UILabel(frame: frame)
        customLabel.text = text
        customLabel.textColor = textColor
        customLabel.textAlignment = textAlignment
        customLabel.font = UIFont.systemFont(ofSize: fontSize)
        return customLabel
    }
    
    //调整间距
    func setColumnSpace(columnSpace:CGFloat) {
        let attributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: columnSpace, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
        
    }
    
    //调整行距
    func setRowSpace(rowSpace:CGFloat){
        // 初始化 attributedText 为一个空的 NSMutableAttributedString
        let attributedText = NSMutableAttributedString()
          
          // 调整行距
          let paragraphStyle = NSMutableParagraphStyle()
          paragraphStyle.lineSpacing = rowSpace
          paragraphStyle.baseWritingDirection = .leftToRight
          paragraphStyle.lineBreakMode = .byTruncatingTail
          
          // 假设 text 是一个属性，类型为 String
          let text = self.text
        attributedText.append(NSAttributedString(string: text!, attributes: [.paragraphStyle: paragraphStyle]))
          
          // 将调整后的 attributedText 赋值给类的属性
          self.attributedText = attributedText
    }
    
    // 设置字体的大小
    func settingLabelTextKitText(text: String,font: UIFont) {
        
        if text.isEmpty {
            return
        }
        
        let attrString = NSMutableAttributedString(string: self.text!)
        
        //1.设置字体
        let rg = (self.text! as NSString).range(of: text)
        attrString.addAttribute(NSAttributedString.Key.font, value: font, range: rg)
        
        self.attributedText = attrString
    }
    
    // 设置字体的大小 颜色
    func settingLabelTextKit(text: String,  font: UIFont,  textColor: UIColor) {
        
        if !text.isEmpty {
            let attrString = NSMutableAttributedString(string: self.text!)
            
            //2.设置字体颜色
            let rg = (self.text! as NSString).range(of: text)
            attrString.addAttribute(NSAttributedString.Key.font, value: font, range: rg)
            
            attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: rg)
            
            self.attributedText = attrString
        }
    }
    
    //设置字体颜色
    func settingLabelTextColor(textColor: UIColor, text: String) {
        
        if !text.isEmpty {
            let attrString = NSMutableAttributedString(string: self.text!)
            
            //2.设置字体颜色
            let rg = (self.text! as NSString).range(of: text)
            attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: rg)
            
            self.attributedText = attrString
        }
    }
    
    //.设置字体的背景颜色
    func settingLabelBackgroundColor(backgroundColor: UIColor, text: String) {
        
        if text.isEmpty {
            return
        }
        let attrString = NSMutableAttributedString(string: self.text!)
        
        //3.设置字体的背景颜色
        let rg = (self.text! as NSString).range(of: text)
        attrString.addAttribute(NSAttributedString.Key.backgroundColor, value: backgroundColor, range: rg)
        
        self.attributedText = attrString
    }
    
}
