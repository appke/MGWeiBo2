//
//  User.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/17.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

@objcMembers
class User: NSObject {

    var profile_image_url: String?  //图像
    var screen_name: String?        //昵称
    var verified_type: Int = -1     //认证等级
    var mbrank: Int = 0              //会员等级
    
    //MARK: 重写构造方法
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }   
}
