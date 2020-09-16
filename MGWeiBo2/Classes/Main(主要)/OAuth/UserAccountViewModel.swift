//
//  UserAccountViewModel.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/16.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class UserAccountViewModel: NSObject {

    static let shared = UserAccountViewModel()
    // 定义属性
    var isLogin: Bool {
        guard let account = account else {
            return false
        }
        
        // 取出过期日期
        guard let expirseDate = account.expires_date else {
            return false
        }
        return expirseDate.compare(Date()) == .orderedDescending
    } 
    
    //MARK: 定义属性，保存账号信息
    var account: UserAccount?
    
    //MARK: 计算属性
    var accountPath: String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        return path + "/account.plist"
    }
    
    override init() {
        super.init()
        // 读取账号信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
        print("accountPath ==== \(accountPath)")
    }
    
//    func isLogin() -> Bool {
//        guard let account = account else {
//            return false
//        }
//
//        // 取出过期日期
//        guard let expirseDate = account.expires_date else {
//            return false
//        }
//
//        return expirseDate.compare(Date()) == .orderedDescending
//    }
}
