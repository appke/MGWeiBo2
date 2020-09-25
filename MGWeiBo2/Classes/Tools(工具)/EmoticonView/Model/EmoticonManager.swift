//
//  EmoticonManager.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/24.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class EmoticonManager: NSObject {

    var packages: [EmoticonPackage] = [EmoticonPackage]()
    
    override init() {
        // 加载表情包
        packages.append(EmoticonPackage(id: ""))
        packages.append(EmoticonPackage(id: "com.sina.default"))
        packages.append(EmoticonPackage(id: "com.apple.emoji"))
        packages.append(EmoticonPackage(id: "com.sina.lxh"))
    }
}
