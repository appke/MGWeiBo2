//
//  PhotoBrowserController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/27.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

private let PhotoBrowserCellId: String = "PhotoBrowserCellId"

class PhotoBrowserController: UIViewController {

    private let indexPath: NSIndexPath
    private let picUrls: [URL]
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PhotoBrowserLayout())
        collectionView.frame = view.bounds
        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.register(PhotoBrowserViewCell.self, forCellWithReuseIdentifier: PhotoBrowserCellId)
        
        return collectionView
    }()
    
    private lazy var closeBtn: UIButton = UIButton(title: "关  闭", fontSize: 14, bgColor: .darkGray)
    private lazy var saveBtn: UIButton = UIButton(title: "保  存", fontSize: 14, bgColor: .darkGray)
    
    
    // 自定义构造函数
    init(indexPath: NSIndexPath, picUrls: [URL]) {
        // 创建之前给它赋值
        self.indexPath = indexPath
        self.picUrls = picUrls
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- 系统回调函数
    override func loadView() {
        super.loadView()
        
        // 控制器的宽度+20 –≥ collectionView的宽度+20 –≥ collectionView的contentView宽度+20
        view.frame.size.width += 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        setupUI()
        
        // 瞬间移动到对应图片
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
    }
    
}

//MARK:- 界面相关
extension PhotoBrowserController {
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        // 设置尺寸
        closeBtn.snp_makeConstraints { (make) in
            make.leading.equalTo(20)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        
        saveBtn.snp_makeConstraints { (make) in
            make.right.equalTo(-20)
            make.bottom.equalTo(self.closeBtn)
            make.size.equalTo(self.closeBtn)
        }
        
        // 监听按钮点击
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
    }
}


//MARK:- 事件监听
extension PhotoBrowserController {
    @objc private func closeBtnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveBtnClick() {
        
        // 1.拿到当前的cell的图片
        let cell = collectionView.visibleCells.last as! PhotoBrowserViewCell
        guard let image = cell.imageView.image else {
            return
        }
        
        // 2.把图片保存到相册
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    /// 保存到相册，字典回调函数
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: Any) {
        var showInfo: String = ""
        if error != nil {
            showInfo = "保存失败"
        } else {
            showInfo = "保存成功"
        }
        
        SVProgressHUD.showInfo(withStatus: showInfo)
    }
    
}

extension PhotoBrowserController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoBrowserCellId, for: indexPath) as! PhotoBrowserViewCell
        cell.picUrl = picUrls[indexPath.row]
        cell.delegate = self
        //cell.backgroundColor = indexPath.row % 2 == 0 ? .orange : .magenta
        
        return cell
    }
}

//MARK:- 遵守PhotoBrowserViewCellDelegate
extension PhotoBrowserController: PhotoBrowserViewCellDelegate {
    func imageViewClick() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK:- 自定义collectionView布局
class PhotoBrowserLayout: UICollectionViewFlowLayout {
    override func prepare() {
        itemSize = collectionView!.bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
        
        // 设置collectionView的属性
        collectionView?.bounces = false
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.contentInset = .zero
    }
}
