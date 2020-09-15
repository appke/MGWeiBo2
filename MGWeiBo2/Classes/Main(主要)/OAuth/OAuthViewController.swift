//
//  OAuthViewController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/15.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

/**
 App Key：3204583937
 App Secret：205130042e0e31678899faa5e28d756d
 回调地址：https://open.weibo.com
 https://api.weibo.com/oauth2/authorize?client_id=3204583937&redirect_uri=https://open.weibo.com
 
 https://open.weibo.com/?code=5a3b86b3af38c1bf00eb7da9ee733d75

 */

class OAuthViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationItem()
        let ulrStr = "https://api.weibo.com/oauth2/authorize?client_id=3204583937&redirect_uri=https://open.weibo.com/"
        
        webView.loadRequest(URLRequest(url: URL(string: ulrStr)!))
    }
}

extension OAuthViewController {
    func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillItemClick))
        title = "登录页面"
    }
}

extension OAuthViewController {
    @objc private func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func fillItemClick() {
        print(#function)
    }
}
