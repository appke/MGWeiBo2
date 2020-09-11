//
//  HomeViewController.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addRotation()
        
        setupNavigationBar()
    }
    
}

//MARK:- 设置UI界面 
extension HomeViewController {
    private func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
    }
}
