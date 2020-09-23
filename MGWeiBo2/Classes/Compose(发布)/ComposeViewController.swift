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
    
    //MARK: 拖线属性
    @IBOutlet weak var toolBarBottomConst: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavgationBar()
        
        // 监听键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChage(_:)), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        composeTextView.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        composeTextView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func composeItemClick() {
        print("compose……")
    }
    
    @objc private func keyboardFrameChage(_ noti: Notification) { 
        // 键盘最终位置
        let endFrame = noti.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        
        // 执行时间
        let duration = noti.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! TimeInterval
        
        // 工具栏距离底部间距
        let margin = UIScreen.main.bounds.height - endFrame.origin.y
        
        self.toolBarBottomConst.constant = margin
        // 执行动画
        UIView.animate(withDuration: duration) {
            // 强制更新
            self.view.layoutIfNeeded()
        }
    }
}

extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 占位label显示/隐藏
        composeTextView.placeholderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
}
