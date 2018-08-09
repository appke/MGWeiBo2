//
//  ViewController.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/18.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// 懒加载表格属性
    lazy var tableView : UITableView = UITableView()
    
    //MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        MGLog(tableView)
    }
    
    
}




extension ViewController : UITableViewDataSource, UITableViewDelegate {
    //MARK: 数据源方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID : String = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = "表格第\(indexPath.row)行"
        
        return cell!
    }
    
    //MARK: 代理方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MGLog("你点击了第-------\(indexPath.row)行")
    }
}

// MARK: - 初始化界面
extension ViewController {
    /// 设置UI界面
    
    func setupUI() {
        view.addSubview(tableView)
        //设置frame
        tableView.frame = view.bounds
        // 设置数据源
        tableView.dataSource = self
        // 设置代理
        tableView.delegate = self
    }
}







