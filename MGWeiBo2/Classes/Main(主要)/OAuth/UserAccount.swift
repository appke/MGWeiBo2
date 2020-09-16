//
//  UserAccount.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/16.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

//@objcMembers 属性不必1个个添加 @objc
class UserAccount: NSObject {

    @objc var access_token: String?
    // 过期时间,秒
    @objc var expires_in: TimeInterval = 0.0 {
        didSet {
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    @objc var uid: String?
    
    /// 过期日期
    @objc var expires_date: Date?
    // 用户昵称
    @objc var screen_name: String?
    // 用户图像地址
    @objc var avatar_large: String?
    
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        // 模型对象转场字典
        return dictionaryWithValues(forKeys: ["access_token", "expires_date", "uid", "screen_name", "avatar_large"]).description
    }
}

/**
"access_token" = "2.00xRuvQChfGsUD9cf1df3393avy_eC";
"expires_in" = 157679999;
isRealName = true;
"remind_in" = 157679999;
uid = 2082488113;
*/
