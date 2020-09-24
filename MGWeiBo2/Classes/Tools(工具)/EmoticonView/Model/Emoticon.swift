//
//  Emoticon.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/24.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

@objcMembers
class Emoticon: NSObject {

    var code: String?       //emoji的code
    var png: String?        //普通表情对应，图片名称
    var chs: String?        //普通表情对应的文字
    
    init(dict: [String: String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["code", "png", "chs"]).description
    }
}
