//
//  HomeViewController.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit
import AFNetworking

class HomeViewController: BaseViewController {
    
    private lazy var titleBtn: TitleButton = TitleButton()
    private lazy var popverAnimator: PopoverAnimator = PopoverAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addRotation()
        
        setupNavigationBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        let shareInstance = AFHTTPSessionManager()
//        shareInstance.responseSerializer.acceptableContentTypes?.insert("text/html")
//        // 发送网络请求 
//        AFHTTPSessionManager().get("http://httpbin.org/get", parameters: ["name": "mul2"], headers: nil, progress: nil, success: { (task: URLSessionDataTask, result: Any?) in
//            print(result!)
//        }) { (task: URLSessionDataTask?, error: Error) in
//            print(error)
//        }
    }
    
}

//MARK:- 设置UI界面 
extension HomeViewController {
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        // 设置titleView
        titleBtn.setTitle("helloAppke", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

//MARK:- 事件监听
extension HomeViewController {
    @objc private func titleBtnClick() {
        
        let vc = PopoverViewController()
//        vc.view.backgroundColor = .magenta 
        
        // 设置控制器的modal样式
        vc.modalPresentationStyle = .custom
        // 设置转场代理
        vc.transitioningDelegate = popverAnimator
//        popverAnimator.
        popverAnimator.presentedBlack = { [weak self] (isPresnted: Bool)->() in
            self?.titleBtn.isSelected = isPresnted
        }
        
        present(vc, animated: true, completion: nil)
    }
}
