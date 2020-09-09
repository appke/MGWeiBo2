//
//  MainViewController.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    private lazy var composeBtn: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // iOS7 文字图片 都设置
        tabBar.tintColor = UIColor.orange
//        addChildViewControllers()
        
        // 2020-09-09 切换storyboard创建
        
        // 添加中间发布按钮
        tabBar.addSubview(composeBtn)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        
        // 自动调整尺寸 必须要写,否则没有尺寸
        composeBtn.sizeToFit()
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height*0.5)
        
        composeBtn.addTarget(self, action: #selector(compse), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // 可以在SB中设置
//        let composeItem = tabBar.items![2]
//        // 发布按钮不可点击
//        composeItem.isEnabled = false
        
    
    }
    
    
    @objc private func compse() {
        MGLog("------ \(#function)")
    }
}



extension MainViewController {
    /// 添加所有子控制器
    func addChildViewControllers() {

        // 获得文件名
        guard let filePath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            MGLog("json文件不存在")
            return
        }
        
        // 读取json数据
        guard let data = NSData(contentsOfFile: filePath) else {
            MGLog("加载二进制数据失败")
            return
        }
        
        do { //网络加载
            // 将json转换为对象(服务器)
            let objc = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String : Any]]
            
            for dict in objc {
                // 第一步要告诉它是个String? 类型
                let vcName = dict["vcName"] as? String
                let imageName = dict["imageName"] as? String
                let title = dict["title"] as? String
                // 强制拆包
                addChildViewController(vcName, title: title, imageName: imageName)
            }
        } catch { // 从本地加载
            addChildViewController("HomeViewController", title: "首页", imageName: "tabbar_home")
            addChildViewController("MessageViewController", title: "消息", imageName: "tabbar_message_center")
            addChildViewController("DiscoverViewController", title: "发现", imageName: "tabbar_discover")
            addChildViewController("ProfileViewController", title: "我", imageName: "tabbar_profile")
        }
    }
    
    /// 添加子控制器，重载系统方法，扩充
    private func addChildViewController(_ childVcStr: String?, title : String?, imageName : String?) {
        
        guard let childVc = transStringToClass(childVcStr) else {
            MGLog("创建控制器失败")
            return
        }
        
        // 设置chileVc属性
        childVc.title = title;
        if let ivName = imageName {
            childVc.tabBarItem.image = UIImage(named: ivName);
            // .withRenderingMode(.alwaysOriginal) 文字还是蓝色
            childVc.tabBarItem.selectedImage = UIImage(named: ivName + "_highlighted")
        }
        
        // 包装导航控制器
        let childNav = UINavigationController(rootViewController: childVc)
        addChild(childNav)
    }
    
    /// 字符串创建类型
    func transStringToClass(_ name:String?) -> UIViewController? {
        // 1.拿到命名空间
        guard let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            MGLog("获取不到命名空间")
            return nil
        }

        // 2.转成类型Class -> AnyClass
        var className: Any? = nil
        if let vcName = name {
            className = NSClassFromString(spaceName + "." + vcName)
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
