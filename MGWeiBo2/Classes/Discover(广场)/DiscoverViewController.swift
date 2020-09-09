//
//  DiscoverViewController.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit

class DiscoverViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton.init(type: .contactAdd)
        view.addSubview(button)
        button.center = CGPoint(x: 100, y: 100)
        button.addTarget(self, action: #selector(push2NextVC), for: .touchUpInside)
    }
    
    @objc func push2NextVC() {
        let vc: RedViewController = RedViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
