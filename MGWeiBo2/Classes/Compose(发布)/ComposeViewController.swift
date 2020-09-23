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
    lazy private var images: [UIImage] = [UIImage]()
    
    //MARK: 控件属性
    @IBOutlet weak var composeTextView: ComposeTextView!
    @IBOutlet weak var picPickerCollectionView: PicPickerCollectionView!
    
    
    //MARK: 拖线属性
    @IBOutlet weak var toolBarBottomConst: NSLayoutConstraint!
    @IBOutlet weak var picPickerViewHConst: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavgationBar()
        
        setupNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        composeTextView.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK:- UI相关
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

//MARK:- 注册通知
extension ComposeViewController {
    private func setupNotification() {
        // 监听键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChage(_:)), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addPhotoClick), name: Notification.Name.init(rawValue: PicPickerPhotoNote), object: nil)
    }
}

//MARK:- 添加照片相关通知
extension ComposeViewController {
    @objc func addPhotoClick() {
        print("---\(#function)")
        
        // 1.判断照片源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        
        // 2.创建照片选择器
        let ipc = UIImagePickerController()
        ipc.delegate = self
        
        // 3.弹出照片选择器
        present(ipc, animated: true, completion: nil)
    }
}

//MARK:- 选择照片 UIImagePickerController 代理
extension ComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 获取选中照片
        let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as! UIImage
        // 添加到数组中
        if !images.contains(image) {
            images.append(image)
        }
        
        picPickerCollectionView.images = images
        
        // 注定退出
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK:- 事件监听
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
    
    // 选择图片
    @IBAction func picPickerBtnClick() {
        composeTextView.resignFirstResponder()
        
        picPickerViewHConst.constant = UIScreen.main.bounds.width
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}

//MARK:- 代理方法
extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 占位label显示/隐藏
        composeTextView.placeholderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
}
