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
    private lazy var viewModels: [StatusViewModel] = [StatusViewModel]()
    
    
    @IBOutlet weak var tableView: UITableView!
//    private lazy var tableView: UITableView = {
//        let tb: UITableView = UITableView(frame: CGRect.zero, style: .plain)
//        tb.delegate = self
//        tb.dataSource = self
//        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//
//        return tb
//    }()
//    // 重写后BaseViewController的loadView()就不会调用，加载不了访客vc
//    override func loadView() {
//        view = tableView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addRotation()
        
        setupNavigationBar()
        
        if UserAccountViewModel.shared.isLogin {
            loadStatuses()
        }
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

//MARK:- 请求数据
extension HomeViewController {
    private func loadStatuses() {
        NetworkTools.shared.loadStatuses { (result: [[String : Any]]?, error: Error?) in
            // 1.错误校验
            if let error = error {
                print(error)
                return
            }
            
            // 2.获得数组中数据
            guard let reslutArray = result else {
                return
            }
            
            // 3.遍历微博字典
            for statusDict in reslutArray {
                // 字典转模型
                let status = Status(dict: statusDict)
                let viewModel = StatusViewModel(status: status)
                self.viewModels.append(viewModel)
            }
            
            // 刷新表格
            self.tableView.reloadData()
        }
    }
}

//MARK:- tableView代理、数据源
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    } 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeViewCell
        cell.viewModel = viewModels[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(" ----- \(indexPath.row)")
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
