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
    var isLogin: Bool = false
    lazy var visitorView = VisitorView.visitorView()
    
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationItems()
    }
    
}

//MARK:- 获得访客视图
extension BaseViewController {
    /// 设置访客视图
    private func setupVisitorView() {
//        visitorView.backgroundColor = .purple
        view = visitorView
    }
    
    /// 设置导航栏左右的Item
    private func setupNavigationItems() {

    }
}
