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

    var code: String? {
        didSet {
            guard let code = self.code else {
                return
            }
            
            let scanner = Scanner(string: code)
            var value: UInt32 = 0
            scanner.scanHexInt32(&value)
            
            let c = Character(UnicodeScalar(value)!)
            emojiCode = String(c)
            
        }
    } //emoji的code
    var png: String? {
        didSet {
            guard let png = png else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    } //普通表情对应，图片名称
    var chs: String?        //普通表情对应的文字
    
    var pngPath: String?    //png全路径
    var emojiCode: String?  //emoji表情
    
    
    init(dict: [String: String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["emojiCode", "chs", "pngPath"]).description
    }
}
