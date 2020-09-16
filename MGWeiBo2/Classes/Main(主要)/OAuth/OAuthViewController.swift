//
//  OAuthViewController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/15.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

class OAuthViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationItem()
        
        loadWebView()
    }
}

//MARK:- 导航按钮相关
extension OAuthViewController {
    func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillItemClick))
        title = "登录页面"
    }
    
    func loadWebView() {
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
}

//MARK:- 事件监听
extension OAuthViewController {
    @objc private func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func fillItemClick() {
        // java --- javaScript  雷锋、雷峰塔
        let jsCode = "document.getElementById('loginName').value='467603639@qq.com';document.getElementById('loginPassword').value='9904529';"
        
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}


//MARK:- xib已经连线，实现webView协议
extension OAuthViewController: UIWebViewDelegate{
    /// 开始加载网页
    func webViewDidStartLoad(_ webView: UIWebView) {
        MBProgressHUD.show()
    }
    
    /// 加载网页结束
    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.hideHUD()
    }

    /// 加载网页失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        MBProgressHUD.hideHUD()
    }
    
    /// 正准备开始加载某页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        // 1. 拿到网页的URL
        guard let url = request.url else {
            // 没有值，继续加载
            return true
        }
        
        // 2. 获取url中的字符串
        let urlString = url.absoluteString
        
        // 3.是否包含code=
        guard urlString.contains("code=") else {
            return true
        }
        
        // 把code取出来
        let code =  urlString.components(separatedBy: "code=").last!
        print("====== code = \(code)")
        
        loadAccessToken(code)
        // 有code的页面不加载
        return false
    }
}

//MARK:- 请求数据
extension OAuthViewController {
    /// 用code交换access_token
    private func loadAccessToken(_ code: String) {
        
        var param: [String: Any] = [String: Any]()
        param["client_id"] = app_key
        param["client_secret"] = app_secret
        param["grant_type"] = "authorization_code"
        param["code"] = code
        param["redirect_uri"] = redirect_uri
        
        AFHTTPSessionManager().post("https://api.weibo.com/oauth2/access_token", parameters: param, headers: nil, progress: nil, success: { (task: URLSessionDataTask, result: Any?) in
            
            guard let result = result as? [String: Any] else {
                return
            }
            
            let account = UserAccount(dict: result)
            
            self.loadUserInfo(account)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            print(error)
        }
    }
    
    ///  请求用户信息
    private func loadUserInfo(_ account : UserAccount) {
        let param = ["access_token": account.access_token, "uid": account.uid]
        
        AFHTTPSessionManager().get("https://api.weibo.com/2/users/show.json", parameters: param, headers: nil, progress: nil, success: { (task: URLSessionDataTask, result: Any?) in
            print(result!)
            
            guard let result = result as? [String: Any] else {
                print("没有返回用户信息")
                return
            }
            
            account.screen_name = result["screen_name"] as? String
            account.avatar_large = result["avatar_large"] as? String
            
            print(account)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            print("error: \(error)")
        }
    }
}

