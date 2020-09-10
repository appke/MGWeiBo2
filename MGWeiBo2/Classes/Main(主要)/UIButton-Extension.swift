//
//  UIButton-Extension.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/9.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

extension UIButton {
    // 类方法，类似OC中的+开头的方法
    /// 根据2张图片创建UIButton
    class func createButton(imageName: String, bgImageName: String) -> UIButton {
        // 创建按钮
        let button = UIButton()
        
        // 设置属性
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        button.setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        button.sizeToFit()
        
        return button
    }
    
    /// 通过构造函数创建
    convenience init(imageName: String, bgImageName: String) {
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        
        sizeToFit()
    }
}
