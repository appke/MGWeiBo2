//
//  AppDelegate.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/18.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit
//import QorumLogs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var defaultViewController: UIViewController? {
        let isLogin = UserAccountViewModel.shared.isLogin
        return isLogin ? WelcomeViewController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 设置全局颜色
        UITabBar.appearance().tintColor = .orange
        UINavigationBar.appearance().tintColor = .orange
        
        // 创建window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = defaultViewController
        window?.makeKeyAndVisible()
        
//        let packages = EmoticonManager().packages
//        for package in packages {
//            for emoticon in package.emoticons {
//                print(emoticon)
//            }
//        }
        
        return true
    }
}



/// 自定义Log
func MGLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    /// 全局打印函数， 任何地方都可以访问
    /// 第二个参数开始，默认值
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        // print("\(fileName):[\(funcName)](\(lineNum))-\(message)")
        print("\(fileName):[\(lineNum)] - \(message)")
    #endif
}

//func MGLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
//    #if DEBUG
//    let fileName = (file as NSString).lastPathComponent
//    print("\(fileName):[\(funcName)](\(lineNum))-\(message)")
//    #endif
//}


