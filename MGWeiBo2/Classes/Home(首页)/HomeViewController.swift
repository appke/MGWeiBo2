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
        
        let vc = PopoverViewController()
//        vc.view.backgroundColor = .magenta 
        
        // 设置控制器的modal样式
        vc.modalPresentationStyle = .custom
        // 设置转场代理
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
    }
}

//MARK:- 代理相关
extension HomeViewController: UIViewControllerTransitioningDelegate {
    // 自定义弹出view的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MGPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    // 自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    // 自定义消失动画
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
    
    
}

//MARK:- 转场动画相关
extension HomeViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 拿到弹出的view
        let presetedView = transitionContext.view(forKey: .to)!
        
        // 将弹出view添加到containView中
        transitionContext.containerView.addSubview(presetedView)
        
        // 执行动画
        presetedView.transform = CGAffineTransform(scaleX: 1.0, y: 0)
        // 动画从中间开始？–≥ 设置锚点
        presetedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView .animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presetedView.transform = CGAffineTransform.identity
        }) { (_)->() in
            // 必须告诉转场上下文，动画已经结束
            transitionContext.completeTransition(true)
        }
        
        
    }
    
    
}
