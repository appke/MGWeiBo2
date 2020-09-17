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
    var verified_type: Int = -1 {
        didSet {
            switch verified_type {
            case 0:
                verifiedImage = UIImage(named:"avatar_vip")
            case 2, 3, 5:
                verifiedImage = UIImage(named:"avatar_enterprise_vip")
            case 220:
                verifiedImage = UIImage(named:"avatar_grassroot")
            default:
                verifiedImage = nil
            }
        }
    }     //认证等级
    var mbank: Int = 0 {
        didSet {
            if mbank > 0 && mbank <= 6 {
                vipImage = UIImage(named: "common_icon_membership_level\(mbank)")
            }
        }
    }             //会员等级
    
    //MARK: 对用户数据处理属性
    var verifiedImage: UIImage?
    var vipImage: UIImage?
    
    
    //MARK: 重写构造方法
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }   
}
