//
//  MessageViewController.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController  {
    
    lazy var tableView: UITableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

//MARK:- 表格
extension MessageViewController {
    /// 设置UI相关
    func setupUI() {
        
        guard isLogin else {
            return
        }
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK:- 表格数据源、代理方法
extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = "测试数据 --- \(indexPath.row)"
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 29
    }
    
    
    //MARK:- 代理方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MGLog("点击了 --- \(indexPath.row)")
    }
}
