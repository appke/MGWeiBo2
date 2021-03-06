//
//  PhotoBrowserAnimator.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/27.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

protocol PhotoBrowserPresentedDelegate : NSObjectProtocol {
    // 1.提供弹出的imageView
    func imageForPresent(indexPath : NSIndexPath) -> UIImageView
    
    // 2.提供弹出的imageView的frame
    func startRectForPresent(indexPath : NSIndexPath) -> CGRect
    
    // 3.提供弹出后imageView的frame
    func endRectForPresent(indexPath : NSIndexPath) -> CGRect
}

protocol PhotoBrowserDismissDelegate : NSObjectProtocol {
    // 1.提供退出的imageView
    func imageViewForDismiss() -> UIImageView
    
    // 2.提供退出的indexPath, 就可知消失最后的frame
    func indexPathForDismiss() -> NSIndexPath
}


class PhotoBrowserAnimator: NSObject {
    // 定义变量,用于记录是弹出动画还是销毁动画
    var isPresented : Bool = false
    
    // 定义indexPath和presentedDelegate属性
    var indexPath : NSIndexPath?
    var presentedDelegate : PhotoBrowserPresentedDelegate?
    
    // 定义消失的DismissDelegate
    var dismissDelegate : PhotoBrowserDismissDelegate?
    
    // 定义快速设置属性的函数
    func setProperty(_ indexPath : NSIndexPath, presentedDelegate : PhotoBrowserPresentedDelegate, dismissDelegate : PhotoBrowserDismissDelegate) {
        self.indexPath = indexPath
        self.presentedDelegate = presentedDelegate
        self.dismissDelegate = dismissDelegate
    }
}

extension PhotoBrowserAnimator : UIViewControllerTransitioningDelegate {
    
    // 该方法是告诉系统,弹出动画交给谁来处理
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    // 该方法是告诉系统,消失动画交给谁来处理
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}


extension PhotoBrowserAnimator : UIViewControllerAnimatedTransitioning {
        
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? presentAnimate(transitionContext: transitionContext) : dismissAnimate(transitionContext: transitionContext)
    }
    
    
    /// 弹出动画的封装
    func presentAnimate(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let presentedDelegate = presentedDelegate, let indexPath = indexPath else {
            return
        }
        
        // 1.取出弹出的View
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // 2.将弹出的View,添加到containerView中
        transitionContext.containerView.addSubview(presentedView)
        
        let tempImageView = presentedDelegate.imageForPresent(indexPath: indexPath)
        tempImageView.frame = presentedDelegate.startRectForPresent(indexPath: indexPath)
        transitionContext.containerView.addSubview(tempImageView)
        transitionContext.containerView.backgroundColor = .black
        
        // 3.执行动画
        presentedView.alpha = 0.0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            tempImageView.frame = presentedDelegate.endRectForPresent(indexPath: indexPath)
        }) { (_) -> Void in
            transitionContext.containerView.backgroundColor = .clear
            transitionContext.completeTransition(true)
            tempImageView.removeFromSuperview()
            presentedView.alpha = 1.0
        }
    }
    
    
    /// 消失动画的封装
    func dismissAnimate(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let dismissDelegate = dismissDelegate, let presentedDelegate = presentedDelegate else {
            return
        }
        
        // 1.取出消失的View
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        dismissView?.alpha = 0
        
        let tempImageView = dismissDelegate.imageViewForDismiss()
        transitionContext.containerView.addSubview(tempImageView)
        
        // 2.执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            
            // 有indexPath就可以最终的frame
            tempImageView.frame = presentedDelegate.startRectForPresent(indexPath: dismissDelegate.indexPathForDismiss())
            
        }) { (_) -> Void in
            tempImageView.removeFromSuperview()
            dismissView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
