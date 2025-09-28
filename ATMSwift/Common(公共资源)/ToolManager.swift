//
//  ToolManager.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//

import UIKit

class ToolManager: NSObject {

    // MARK: - 单例实例
     static let shared = ToolManager()
     private override init() {}
     
     // MARK: - 数据存储
     private let userDefaults = UserDefaults.standard
     
     func saveData(_ value: Any, forKey key: String) {
         userDefaults.set(value, forKey: key)
     }
     
     func getData(forKey key: String) -> Any? {
         return userDefaults.value(forKey: key)
     }
    
    
     func maskMiddleFourDigits(_ phoneNumber: String) -> String {
           // 去除所有非数字字符
           let digits = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
           
           // 检查手机号长度是否符合要求（11位）
//           guard digits.count == 11 else {
//               return phoneNumber // 不符合长度要求则返回原始值
//           }
           
           // 截取并替换中间四位
           let startIndex = digits.startIndex
           let prefix = String(digits[startIndex..<digits.index(startIndex, offsetBy: 3)])
           let suffix = String(digits[digits.index(startIndex, offsetBy: 7)...])
           
           return "\(prefix)****\(suffix)"
       }
}
