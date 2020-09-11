//
//  HomeViewController.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    lazy var titleBtn: TitleButton = TitleButton()
    
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
        
        // 设置titleView
        titleBtn.setTitle("helloAppke", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(button:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

extension HomeViewController {
    @objc private func titleBtnClick(button: TitleButton) {
        button.isSelected = !button.isSelected
        
        let vc = PopoverController()
        vc.view.backgroundColor = .magenta
        
        // 设置控制器的modal样式
        vc.modalPresentationStyle = .custom
        
        present(vc, animated: true, completion: nil)
    }
}
