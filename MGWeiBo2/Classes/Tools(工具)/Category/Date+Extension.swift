//
//  Date+Extension.swift
//  WBDemo
//
//  Created by Meng on 17/2/14.
//  Copyright © 2017年 demo. All rights reserved.
//

import Foundation

extension Date {
    // 字符串转date
    static func createDate(creatAtStr: String) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "EE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        
        guard let createDate = fmt.date(from: creatAtStr) else {
            return ""
        }
        
        
        // 计算创建时间和当前时间的时间差
        let interval = Int(Date().timeIntervalSince(createDate))
        
        if interval < 60 {
            return "刚刚"
        } else if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        } else if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        // 创建日历对象
        let calendar = Calendar.current
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
        }
        
        // 是否超过1年
        let cmps = calendar.dateComponents([.year], from: createDate, to: Date())
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
        } else {
            fmt.dateFormat = "yyyy-MM-dd HH:mm"
        }
        
        return fmt.string(from: createDate)
    }
}

/**
    刚刚(一分钟内)
    X分钟前(一小时内)
    X小时前(当天)
    昨天 HH:mm(昨天)
    MM-dd HH:mm(一年内)
    yyyy-MM-dd HH:mm(更早期)
*/

