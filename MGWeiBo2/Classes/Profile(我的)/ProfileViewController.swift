//
//  ProfileViewController.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setupVisitorInfo(iconName: "visitordiscover_image_profile", title: "登录后，别人评论你的微博，给你发消息，都会在在这里收到通知")
    }
}
