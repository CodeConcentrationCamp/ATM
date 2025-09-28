//
//  importPod.swift
//  StudySwift
//
//  Created by binbin.c on 2025/9/3.
//

import Foundation
import SnapKit
import HandyJSON
import Kingfisher
//import FSPagerView



extension String {
    static func randomAlphanumeric(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func randomAlphanumeric(minLength: Int = 4, maxLength: Int = 10) -> String {
        let length = Int.random(in: minLength...maxLength)
        return randomAlphanumeric(length: length)
    }
}


