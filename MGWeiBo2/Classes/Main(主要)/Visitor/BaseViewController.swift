//
//  BaseViewController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/10.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    /// 是否登录，没登录显示访客视图
    var isLogin: Bool = UserAccountViewModel.shared.isLogin
    lazy var visitorView = VisitorView.visitorView()
    
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin {
            setupNavigationItems()
        }   
    }
}

//MARK:- 获得访客视图
extension BaseViewController {
    /// 设置访客视图
    private func setupVisitorView() {
//        visitorView.backgroundColor = .purple
        view = visitorView
        
        visitorView.registerBtn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
    }
    
    /// 设置导航栏左右的Item
    private func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginClick))
    }
}


//MARK:- 监听Item点击
extension BaseViewController {
    @objc private func registerClick() {
        MGLog("\(#function)")
    }
    
    @objc private func loginClick() {
        let oAuth = OAuthViewController()
        let nav = UINavigationController(rootViewController: oAuth)
        present(nav, animated: true, completion: nil)
    }
}
