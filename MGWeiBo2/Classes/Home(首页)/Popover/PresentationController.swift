//
//  PresentationController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/14.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {

    private lazy var coverView = UIView()
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        // 设置弹出view的frame
        presentedView?.frame = CGRect.init(x: 10, y: 55, width: 180, height: 250)
        presentedView?.center.x = UIScreen.main.bounds.width * 0.5
        
        // 添加蒙版
        // containerView?.backgroundColor = UIColor.init(white: 0.8, alpha: 0.5)
        setupCoverView()
        
    }
}

extension PresentationController {
    private func setupCoverView() {
//        containerView?.addSubview(coverView)
        containerView?.insertSubview(coverView, at: 0)
        coverView.frame = containerView!.bounds
        coverView.backgroundColor = UIColor.init(white: 0.8, alpha: 0.2)
        
        // 添加手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tap)
    }
}

extension PresentationController {
    @objc private func coverViewClick() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
