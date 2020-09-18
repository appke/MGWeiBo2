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
    var profileURL: URL?

    
    init(status: Status) {
        super.init()
        
        self.status = status
        // 1.处理来源
        // nil值校验  不等于""
        if let source = status.source, status.source != "" {
            // "source": "<a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>",
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            sourceText = "来自"+(source as NSString).substring(with: NSRange(location: startIndex, length: length))
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
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        if mbrank == 7 {
            vipImage = UIImage(named: "common_icon_membership")
        }
        
        // 5.用户图像处理
        let profileURLstring = status.user?.profile_image_url ?? ""
        profileURL = URL(string: profileURLstring)
    }
}
