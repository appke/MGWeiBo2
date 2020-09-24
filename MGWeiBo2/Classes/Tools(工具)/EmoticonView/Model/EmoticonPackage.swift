//
//  EmoticonPackage.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/24.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {

    var emoticons: [Emoticon] = [Emoticon]()
    
    init(id: String) {
        // 1.最近分组
        if id == "" {
            return
        }
        
        // 根据id拼接info.plist路径
        // inDirectory 在那个文件夹下
        let plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        
        // 根据plist路径，加载里面的数组
        let array = NSArray(contentsOfFile: plistPath) as! [[String: String]]
        
        var index = 0
        for var dict in array {
            if let png = dict["png"] {
                dict["png"] = "\(id)/" + png
            }
            emoticons.append(Emoticon(dict: dict))
            
            index += 1
            if index == 20 {
                emoticons.append(Emoticon(isRemove: true))
                index = 0
            }
        }
    }
}
