//
//  ColorMacros.swift
//  StudySwift
//
//  Created by binbin.c on 2025/9/3.
//

import UIKit
// MARK: - 颜色设置

/// RGB颜色设置：支持(255, 255, 255)
func BBColor(_ r:CGFloat, _ g:CGFloat,_ b:CGFloat) -> UIColor {
    return UIColor(red: CGFloat(r) / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
}
func BBColorA(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
func BBRandomColor() -> UIColor {
    return BBColor(CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)))
}


/// 十六进制颜色设置：支持#FF0000
func UIColorFromHex(_ rgbValue: String) -> UIColor? {
    return UIColor.bb_hexColor(rgbValue, alpha: 1.0)
}
func UIColorFromHexA(_ rgbValue: String,_ a:CGFloat) -> UIColor? {
    return UIColor.bb_hexColor(rgbValue, alpha: a)
}

/// 主题色--背景色
let Default_BackGround_Color =  UIColorFromHex("0xEFDFBF")
let Default_Black0_Color = UIColorFromHex("0x000000")
let Default_Black3_Color = UIColorFromHex("0x333333")
let Default_Black6_Color = UIColorFromHex("0x666666")
let Default_Black9_Color = UIColorFromHex("0x999999")
let Default_Line_Color = UIColorFromHex("0xE5E5E5")
let Default_Red_Color = UIColorFromHex("0xDF2A4A")
let Default_Green_Color = UIColorFromHex("0x3EB664")
let Default_Blue_Color = UIColorFromHex("0x83A2F8")
let Default_Origin_Color = UIColorFromHex("0xFFAA33")

