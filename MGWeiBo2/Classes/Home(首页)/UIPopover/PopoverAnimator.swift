//
//  PopoverAnimator.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/14.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    /// 是否弹出动画
    private var isPresented: Bool = false
    
    /// 对外暴露属性
    public var presentedBlack: ((Bool)->())? = nil
}

//MARK:- 代理相关
extension PopoverAnimator: UIViewControllerTransitioningDelegate {
    // 自定义弹出view的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MGPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    // 自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    // 自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}

//MARK:- 转场动画相关
extension PopoverAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animateForPresentedView(transitionContext: transitionContext) : animateForDismissedView(transitionContext: transitionContext)
        
        // 改变titleButton状态的属性
        guard let block = presentedBlack else {
            return
        }
        block(isPresented)
    }
    
    /// 弹出动画
    private func animateForPresentedView(transitionContext: UIViewControllerContextTransitioning) {
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
    
    /// 消失动画
    private func animateForDismissedView(transitionContext: UIViewControllerContextTransitioning) {
        // 拿到消失的view
        let dismissedView = transitionContext.view(forKey: .from)!
        
        // 已经存在不用在添加，执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissedView.transform = CGAffineTransform(scaleX: 1.0, y: 0.8) //0.00001 //x轴1倍不变，y轴消失，对临界值处理不好
        }) { (_)->() in
            dismissedView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}

