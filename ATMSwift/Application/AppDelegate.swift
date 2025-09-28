//
//  AppDelegate.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow.init()
        self.window?.backgroundColor = Default_BackGround_Color!
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
        PageRouter.changeHomeOrLoginPage()
        
        
        
        
        return true
    }




}




