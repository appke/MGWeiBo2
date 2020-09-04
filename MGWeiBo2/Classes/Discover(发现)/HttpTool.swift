//
//  HttpTool.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/4.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class HttpTool: NSObject {
    
    var callBack: ((String) -> ())?
    
    
    func loadData(callBack: @escaping(_ jsonData: String) -> ()) {
        
        self.callBack = callBack
        
        DispatchQueue.global().async {
            print("异步发送网络请求：\(Thread.current)")
            
            DispatchQueue.main.async {
                print("回到主线程：\(Thread.current)")
                callBack("json数据。。。。。。")
            }
        }
    }
}
