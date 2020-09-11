//
//  UIBarButtonItem-Extension.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/11.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String) {
//        self.init()
        
        let button = UIButton()
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        // 不用设置尺寸和位置，设置也没用
//        button.sizeToFit()
        
//        customView = button
        
        self.init(customView: button)
    }
}
