//
//  ComposeViewController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/22.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit
import SVProgressHUD

class ComposeViewController: UIViewController {

    lazy private var titleView: ComposeTitleView = ComposeTitleView()
    lazy private var images: [UIImage] = [UIImage]()
    lazy private var emoticonVC = EmoticonViewController { [weak self] (emoticon) in
        self?.textView.insertEmoticon(emoticon)
        self?.textViewDidChange(self!.textView)
    }
    
    //MARK: 控件属性
    @IBOutlet weak var textView: ComposeTextView!
    @IBOutlet weak var picPickerCollectionView: PicPickerCollectionView!
    
    
    //MARK: 拖线属性
    @IBOutlet weak var toolBarBottomConst: NSLayoutConstraint!
    @IBOutlet weak var picPickerViewHConst: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.becomeFirstResponder()
        
        setupNavgationBar()
        
        setupNotification()
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(addPhotoClick), name: Notification.Name.init(rawValue: PicPickerAddPhotoNote), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(delPhotoClick(_:)), name: Notification.Name.init(rawValue: PicPickerDelPhotoNote), object: nil)
    }
}

//MARK:- 添加照片相关通知
extension ComposeViewController {
    @objc private func addPhotoClick() {
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
    
    @objc private func delPhotoClick(_ note: Notification) {
        // 先校验
        guard let image = note.object as? UIImage else {
            return
        }
        
        guard let index = images.firstIndex(of: image) else {
            return
        }
        images.remove(at: index)
        
        // 更新collectionView数据源，刷新表格
        picPickerCollectionView.images = images
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
        
        // 主动退出
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK:- 事件监听
extension ComposeViewController {
    @objc private func closeItemClick() {
        textView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func composeItemClick() {
        textView.resignFirstResponder()
        
        let statusText = textView.getEmoticonString()
        
        NetworkTools.shared.sendStatus(statusText: statusText) { (isSuccess) in
            if !isSuccess {
                SVProgressHUD.showError(withStatus: "发送微博失败")
            } else {
                SVProgressHUD.showSuccess(withStatus: "发送微博成功")
            }
        }
        
//        dismiss(animated: true, completion: nil)
    }
    
    @objc private func keyboardFrameChage(_ note: Notification) {
        // 键盘最终位置
        let endFrame = note.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        
        // 执行时间
        let duration = note.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! TimeInterval
        
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
        textView.resignFirstResponder()
        
        picPickerViewHConst.constant = picPickerViewHConst.constant == 0 ? UIScreen.main.bounds.width : 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    // 表情按钮点击
    @IBAction func emojiBtnClick() {
        print("\(#function)")
        textView.resignFirstResponder()
        // 切换键盘
        textView.inputView = textView.inputView == nil ? emoticonVC.view : nil
        // 弹出键盘
        textView.becomeFirstResponder()
    }
}

//MARK:- 代理方法 
extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 占位label显示/隐藏
        self.textView.placeholderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
}
