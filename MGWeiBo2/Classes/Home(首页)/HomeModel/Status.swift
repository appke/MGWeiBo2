//
//  Status.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/17.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

@objcMembers
class Status: NSObject {

    //MARK: 属性
    var created_at: String?{
        didSet {
            // nil值校验
            guard let create_at = created_at else {
                return
            }
            createAtText = Date.createDate(creatAtStr: create_at)
        }
    } // 创建时间
    var source: String?{
        didSet {
            // 1.nil值校验  不等于""
            guard let source = source, source != ""  else {
                return
            }
            // "source": "<a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>",
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
    }     // 来源
    var text: String?       // 正文
    var mid: Int = 0        // ID
    var user: User?
    
    
    //MARK: 对数据处理的属性
    var sourceText: String?
    var createAtText: String?
    

    //MARK: 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
        
        // 将用户字典转成 用户模型
        if let userDict = dict["user"] as? [String: Any] {
            user = User(dict: userDict)
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}

/**
 "mid": "4550086426629221",
 "created_at": "Thu Sep 17 10:10:03 +0800 2020",
 "source": "<a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>",
 "text": "#琉璃视效# 终极揭秘！"
 
 */
