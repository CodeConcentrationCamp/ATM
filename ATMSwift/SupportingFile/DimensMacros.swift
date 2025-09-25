//
//  DimensMacros.swift
//  WuZhouLoanSwift
//
//  Created by binbin.c on 2023/9/24.
//

import UIKit


// MARK: - 尺寸信息
let KScreenWidth = UIScreen.main.bounds.width
let KScreenHeight = UIScreen.main.bounds.height

let KWidthScale = (KScreenWidth / 375.0)
let KHeightScale = (KScreenHeight / 667.0)

func KScale(value:CGFloat) -> CGFloat {
    return KWidthScale * value
}

/**
 导航栏高度
 */
var navigationBarHeight:CGFloat{
    return 44.0
}

/**
 状态栏+导航栏的高度
 */
var navigationFullHeight:CGFloat{
    return safeDistanceTop + navigationBarHeight
}

/**
 底部导航栏高度
 */
var tabBarHeight:CGFloat{
    return 49.0;
}

/**
 顶部安全区高度
 */
@available(iOS 11.0, *)
var safeDistanceTop: CGFloat {
    if #available(iOS 13.0, *) {
        let set:NSSet!
        let windowSceneset:UIWindowScene!
        let ww:UIWindow!
        set = UIApplication.shared.connectedScenes as NSSet
        windowSceneset = (set.anyObject() as! UIWindowScene)
        ww = windowSceneset.windows.first
       // print("==1顶部安全区高度==%f", ww.safeAreaInsets.top)
        return ww.safeAreaInsets.top
    } else {
        if let window = UIApplication.shared.windows.first {
        //     print("==2顶部安全区高度==%f", window.safeAreaInsets.top)
            return window.safeAreaInsets.top
        }
    }
    return 0
}

/**
 底部安全区高度
 */
@available(iOS 11.0, *)
var safeDistanceBottom: CGFloat {
    if #available(iOS 13.0, *) {
        let set:NSSet!
        let windowSceneset:UIWindowScene!
        let ww:UIWindow!
        set = UIApplication.shared.connectedScenes as NSSet
        windowSceneset = (set.anyObject() as! UIWindowScene)
        ww = windowSceneset.windows.first
        print("底部安全区高度==%f", ww.safeAreaInsets.bottom)
        return ww.safeAreaInsets.bottom
    } else  {
        if let window = UIApplication.shared.windows.first {
             print("底部安全区高度==%f", window.safeAreaInsets.bottom)
            return window.safeAreaInsets.bottom
        }
    }
    return 0
}


/**
 顶部状态栏高度（包括安全区）
 */
var statusBarHeight: CGFloat {
    if #available(iOS 13.0, *) {
        let set:NSSet!
        let windowSceneset:UIWindowScene!
        set = UIApplication.shared.connectedScenes as NSSet
        windowSceneset = (set.anyObject() as! UIWindowScene)
        let statusBarManager:UIStatusBarManager!
        statusBarManager = windowSceneset.statusBarManager
       // print("==顶部状态栏高度（包括安全区）==%f",statusBarManager.statusBarFrame.size.height);
        return statusBarManager.statusBarFrame.size.height
    }else{
        return UIApplication.shared.statusBarFrame.size.height
    }
}


var tabBarFullHeight:CGFloat{
    return safeDistanceBottom+tabBarHeight
}



// MARK: - 打印输出

/// 默认打印
public func NSLog<T>(_ message: T) {
#if DEBUG
    print("\(message)")
#endif
}

/// 全部打印
public func BBAllLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
#if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\n********** BBAllLog-satrt ***********\n文件名称:\(fileName)\n方法名称:\(funcName)\n行数:\(lineNum)\n信息:\n\(message)\n********** BBAllLog-end ***********\n")
#endif
}
