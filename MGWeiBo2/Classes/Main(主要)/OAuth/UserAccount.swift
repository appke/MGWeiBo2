//
//  UserAccount.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/16.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class UserAccount: NSObject {

    @objc var access_token: String?
    @objc var expires_in: Double = 0.0
    @objc var uid: String?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    override var description: String {
        // 模型对象转场字典
        return dictionaryWithValues(forKeys: ["access_token", "expires_in", "uid"]).description
    }
}

/**
"access_token" = "2.00xRuvQChfGsUD9cf1df3393avy_eC";
"expires_in" = 157679999;
isRealName = true;
"remind_in" = 157679999;
uid = 2082488113;
*/
