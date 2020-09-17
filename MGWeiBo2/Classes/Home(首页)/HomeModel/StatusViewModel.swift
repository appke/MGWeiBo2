//
//  StatusViewModel.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/17.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
    
    //MARK: 定义属性
    var status: Status?
    
    //MARK: 对数据处理的属性
    var sourceText: String?
    var createAtText: String?
    var verifiedImage: UIImage?
    var vipImage: UIImage?

    
    init(status: Status) {
        super.init()
        
        self.status = status
        // 1.处理来源
        // nil值校验  不等于""
        if let source = status.source, status.source != "" {
            // "source": "<a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>",
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }

        // 2.处理时间
        if let created_at = status.created_at {
            createAtText = Date.createDate(creatAtStr: created_at)
        }
        
        // 3.对认证图标
        let verifiedType = status.user?.verified_type ?? -1
        switch verifiedType {
        case 0:
            verifiedImage = UIImage(named:"avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named:"avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named:"avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        // 4.会员等级
        let mbank = status.user?.mbank ?? 0
        if mbank > 0 && mbank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbank)")
        }
    }
}
