//
//  MainViewController.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // iOS7 文字图片 都设置
        tabBar.tintColor = UIColor.orange
        addChildViewControllers()
    }
    
    /// 添加所有子控制器
    func addChildViewControllers() {
//        addChildViewController("HomeViewController", title: "首页", imageName: "tabbar_home")
//        addChildViewController("MessageViewController", title: "消息", imageName: "tabbar_message_center")
//        addChildViewController("DiscoverViewController", title: "发现", imageName: "tabbar_discover")
//        addChildViewController("ProfileViewController", title: "我", imageName: "tabbar_profile")
        
        // 读取plist文件中创建
        
        
    }
    
    /// 添加子控制器，重载系统方法，扩充
    private func addChildViewController(_ childVcStr: String, title : String, imageName : String) {
        
        guard let childVc = transStringToClass(childVcStr) else {
            MGLog("\(childVcStr)类名称有错误")
            return
        }
        
        // 设置chileVc属性
        childVc.title = title;
        childVc.tabBarItem.image = UIImage(named: imageName);
        // .withRenderingMode(.alwaysOriginal) 文字还是蓝色
        childVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        // 包装导航控制器
        let childNav = UINavigationController(rootViewController: childVc)
        addChildViewController(childNav)
    }
    
    
    /// 字符串创建类型
    func transStringToClass(_ name:String) -> UIViewController? {
        // 1.拿到命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            MGLog("获取不到命名空间")
            return nil
        }

        // 2.转成类型Class -> AnyClass
        guard let className = NSClassFromString(nameSpace + "." + name) else {
            MGLog("获取不到类名")
            return nil
        }

        // 3.AnyClass转成对应控制器的类型
        guard let typeClass = className as? UIViewController.Type else {
            MGLog("没有获取到对应控制器类型")
            return nil
        }
        
        // 4.创建对应的控制器对象
        return typeClass.init()
    }
}


