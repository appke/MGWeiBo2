//
//  NetworkTools.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/16.
//  Copyright © 2020 穆良. All rights reserved.
//

import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    static let shared = NetworkTools()

}

//MARK:- 封装请求方法

//MARK:- 请求AccessToken
extension NetworkTools {
}

//MARK:- 请求用户信息
extension NetworkTools {
}


//MARK:- 请求首页数据
extension NetworkTools {
    func loadStatuses(finished: @escaping (_ result: [[String: Any]]?, _ error: Error?) -> ()) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let param = ["access_token": (UserAccountViewModel.shared.account?.access_token)!]
//        print("param --- \(param)")
        
        NetworkTools.shared.get(urlString, parameters: param, headers: nil, progress: nil, success: { (task: URLSessionDataTask, result: Any?) in
            
            guard let resultDict = result as? [String: Any] else {
                print("没有获取到数据")
                return
            }
            
            finished(resultDict["statuses"] as? [[String: Any]], nil)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            finished(nil, error)
        }
    }
}
