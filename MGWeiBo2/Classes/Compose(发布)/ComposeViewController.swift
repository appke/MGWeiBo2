//
//  ComposeViewController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/22.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    lazy private var titleView: ComposeTitleView = ComposeTitleView()
    @IBOutlet weak var composeTextView: ComposeTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavgationBar()
    }
}

extension ComposeViewController {
    private func setupNavgationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(composeItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        // 设置标题
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = titleView
    }
}

extension ComposeViewController {
    @objc private func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func composeItemClick() {
        print("compose……")
    }

}
