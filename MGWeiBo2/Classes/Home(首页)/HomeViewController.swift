//
//  HomeViewController.swift
//  MGWeiBo2
//
//  Created by 穆良 on 2016/12/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

import UIKit
import AFNetworking
import MJRefresh

class HomeViewController: BaseViewController {
    
    private lazy var titleBtn: TitleButton = TitleButton()
    private lazy var popverAnimator: PopoverAnimator = PopoverAnimator()
    private lazy var viewModels: [StatusViewModel] = [StatusViewModel]()
    
    private lazy var tipLabel: UILabel = UILabel()
    @IBOutlet weak var tableView: UITableView!
    
    let tipLabelH: CGFloat = 34.0
    var navBarValidH: CGFloat {
        var isMore: Bool = false
        if #available(iOS 11.0, *) {
            isMore = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! > 0.0
        }
        // 导航栏有效高度
        return isMore ? 88-44 : 64-20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard isLogin else {
            visitorView.addRotation()
            return
        }
        
        setupNavigationBar()
        
        tableView.estimatedRowHeight = 200
        
        setupHeaderView()
        
        setupFooterView()
        
        setupTipLabel()
        
        setupNotifications()
    }
}

//MARK:- 设置UI界面
extension HomeViewController {
    
    private func setupHeaderView() {
        // 1.创建
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewStatuses))
        
        // 2.设置header的属性
        header.setTitle("下拉刷新", for: .idle)
        header.setTitle("释放刷新", for: .pulling)
        header.setTitle("加载中...", for: .refreshing)
        
        // 3.设置tableView的header
        tableView.mj_header = header
        
        // 进入刷新状态
        tableView.mj_header?.beginRefreshing()
    }
    
    private func setupFooterView() {
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreStatuses))
    }
    
    
    private func setupTipLabel() {
        // 1.加载label
        navigationController?.navigationBar.insertSubview(tipLabel, at: 0)
        
        // 2.设置尺寸
        tipLabel.frame = CGRect(x: 0, y: navBarValidH - tipLabelH, width: UIScreen.main.bounds.width, height: tipLabelH)
        tipLabel.backgroundColor = .orange
        tipLabel.textColor = .white
        tipLabel.isHidden = true
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textAlignment = .center
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        // 设置titleView
        titleBtn.setTitle("helloAppke", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    /// 注册通知
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(showPhotoBrowser(_:)), name: NSNotification.Name(rawValue: ShowPhotoBrowserNote), object: nil)
    }
}

//MARK:- 事件监听
extension HomeViewController {
    @objc func loadNewStatuses() {
        loadStatuses(true)
    }
    
    @objc func loadMoreStatuses() {
        if UserAccountViewModel.shared.isLogin {
            loadStatuses(false)
        }
    }

    @objc private func titleBtnClick() {
        let vc = PopoverViewController()
        // vc.view.backgroundColor = .magenta
        // 设置控制器的modal样式
        vc.modalPresentationStyle = .custom
        // 设置转场代理
        vc.transitioningDelegate = popverAnimator
        popverAnimator.presentedBlack = { [weak self] (isPresnted: Bool)->() in
            self?.titleBtn.isSelected = isPresnted
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func showPhotoBrowser(_ note: Notification) {
        
        // 1.取出数据
        let indexPtah = note.userInfo![ShowPhotoBrowserIndexKey] as! NSIndexPath
        let picUrls = note.userInfo![ShowPhotoBrowserUrlsKey] as! [URL]
        
        let photoBrowserVc = PhotoBrowserController(indexPath: indexPtah, picUrls: picUrls)
        photoBrowserVc.modalPresentationStyle = .custom //设置弹出样式
        present(photoBrowserVc, animated: true, completion: nil)
    }
}


//MARK:- 请求数据
extension HomeViewController {
    private func loadStatuses(_ isNewData: Bool) {
        // 获取since_id
        var since_id = 0
        var max_id = 0
        if isNewData {
            since_id = viewModels.first?.status?.mid ?? 0
        } else {
            max_id = viewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        NetworkTools.shared.loadStatuses(since_id: since_id, max_id: max_id) {(result: [[String : Any]]?, error: Error?) in
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
            var tempViewModels = [StatusViewModel]()
            // 字典转模型
            for statusDict in reslutArray {
                let status = Status(dict: statusDict)
                let viewModel = StatusViewModel(status: status)
                tempViewModels.append(viewModel)
            }
            
            // 4.拼接数据
            if isNewData {
                // 最新数据
                self.viewModels = tempViewModels + self.viewModels
            } else {
                self.viewModels += tempViewModels
            }
                        
            // 刷新表格
            self.tableView.reloadData()
            
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            
            // 最后显示提示Label
            self.showTipLabel(count: tempViewModels.count)
        }
    }
    
    private func showTipLabel(count: Int) {
        // 设置属性
        tipLabel.isHidden = false
        tipLabel.text = count == 0 ? "没有最新数据" : "\(count)条微博数据"
        
        // 执行动画
        UIView.animate(withDuration: 1.0, animations: {
            self.tipLabel.frame.origin.y = 44
        }) { (_) in
            // 回去的时间、停留的时间
            UIView.animate(withDuration: 1.0, delay: 1.5, options: [], animations: {
                self.tipLabel.frame.origin.y = 10
            }) { (_) in
                self.tipLabel.isHidden = true
            }
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
    
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = viewModels[indexPath.row]
        return viewModel.cellHeight
    }
}
