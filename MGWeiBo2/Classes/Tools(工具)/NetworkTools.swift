//
//  NetworkTools.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/16.
//  Copyright © 2020 穆良. All rights reserved.
//

import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    static let shared: NetworkTools = NetworkTools()

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
    func loadStatuses(since_id: Int, max_id: Int, finished: @escaping (_ result: [[String: Any]]?, _ error: Error?) -> ()) {
        
        // https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.00xRuvQChfGsUD9cf1df3393avy_eC
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        var param: [String: Any] = [String: Any]()
        param["access_token"] = (UserAccountViewModel.shared.account?.access_token)!
        param["since_id"] = since_id
        param["max_id"] = max_id
        
        
        NetworkTools.shared.get(urlString, parameters: param, headers: nil, progress: nil, success: { (task: URLSessionDataTask, result: Any?) in
            
            print("param --- \(param)")
            
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


//MARK:- 发布1条微博
extension NetworkTools {
    
    func sendStatus(statusText: String, isSucess: @escaping (_ isSuccess: Bool)->()) {
        let urlStr = "https://api.weibo.com/2/statuses/share.json"
        var param: [String: Any] = [String: Any]()
        param["access_token"] = (UserAccountViewModel.shared.account?.access_token)!
        param["status"] = statusText
        
        NetworkTools.shared.post(urlStr, parameters: param, headers: nil, progress: nil, success: { (task: URLSessionDataTask, result: Any?) in
            
            isSucess(true)
        }) { (task: URLSessionDataTask?, error: Error) in
            
            print("\(#function) --- error --- \(error)")
            isSucess(false)
        }   
    }
}
