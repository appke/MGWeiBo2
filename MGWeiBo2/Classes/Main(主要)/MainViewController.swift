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
        
        print(HomeViewController())
        
        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(ProfileViewController(), title: "我", imageName: "tabbar_profile")
        
        transStringToClass("HomeViewController")
        
        
        // 1.获取json文件路径
        
        // 2.
    }
    
    // 函数重载 private
    private func addChildViewController(_ childVc: UIViewController, title : String, imageName : String) {
        
        // 设置chileVc属性
        childVc.title = title;
        childVc.tabBarItem.image = UIImage(named: imageName);
        // .withRenderingMode(.alwaysOriginal) 文字还是蓝色
        childVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        // 包装导航控制器
        let childNav = UINavigationController(rootViewController: childVc)
        addChildViewController(childNav)
    }
    
    func transStringToClass(_ name:String) {
        
        // 1.拿到命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("获取不到命名空间")
            return
        }
        
        // 2.转成类型Class -> AnyClass
        guard let className = NSClassFromString(nameSpace + "." + name) else {
            print("获取不到类名")
            return
        }
        
        // 3.AnyClass转成对应控制器的类型
        guard let classType = className as? UIViewController.Type else {
            print("没有获取到对应控制器类型")
            return
        }
        
        // 4.创建对应的控制器对象
        let childVc = classType.init()
        print(childVc)
    }
}


