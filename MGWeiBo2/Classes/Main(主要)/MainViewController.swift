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
        
        
        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(ProfileViewController(), title: "我", imageName: "tabbar_profile")
    
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
}


