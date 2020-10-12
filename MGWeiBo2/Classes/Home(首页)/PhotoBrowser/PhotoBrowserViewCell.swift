//
//  PhotoBrowserViewCell.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/27.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit
import SDWebImage

protocol PhotoBrowserViewCellDelegate: NSObjectProtocol {
    func imageViewClick()
}

class PhotoBrowserViewCell: UICollectionViewCell {
    var picUrl: URL? {
        didSet {
            setupContent(picUrl)
        }
    }
    
    var delegate: PhotoBrowserViewCellDelegate?
    
    private lazy var scrollView: UIScrollView = UIScrollView()
    lazy var imageView: UIImageView = UIImageView()
    private lazy var progressView : ProgressView = ProgressView()
    
    // 重写init方法，初始化数据
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置界面
extension PhotoBrowserViewCell {
    private func setupUI() {
        // 添加子控件
        contentView.addSubview(scrollView)
        // 还是看得见在scrollView外面
        contentView.addSubview(progressView)
        scrollView.addSubview(imageView)
        
        
        // 设置scrollView的尺寸
        scrollView.frame = contentView.bounds
        // 不能bounds，会移动frame的x值
        scrollView.frame.size.width -= 20
        imageView.isUserInteractionEnabled = true
        
        progressView.isHidden = true
        progressView.backgroundColor = .clear
        progressView.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = CGPoint(x: contentView.bounds.width * 0.5, y: contentView.bounds.height * 0.5)
        
        // 监听图片的点击
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        imageView.addGestureRecognizer(tap)
    }
}
//MARK:- 监听图片点击
extension PhotoBrowserViewCell {
    @objc private func imageViewClick() {
        delegate?.imageViewClick()
    }
}

//MARK:- 设置Cell内容
extension PhotoBrowserViewCell {
    private func setupContent(_ picUrl: URL?) {
        // 1.空值校验
        guard let picUrl = picUrl else {
            return
        }
        
        // 2.取出小image
        var smallImage = UIImage(named: "empty_picture")
        SDWebImageManager.shared.imageCache.queryImage(forKey: picUrl.absoluteString, options: [], context: nil, cacheType: .disk) { (image, _, _) in
            
            if image != nil {
                smallImage = image
            }
            
            // 3.计算imageView的位置和尺寸
            self.calculateImageViewFrame(smallImage!)
            
            // 4.下载大图
            self.progressView.isHidden = false
            self.imageView.sd_setImage(with: self.bigImageURL(picUrl), placeholderImage: smallImage, options: [], context: nil, progress: { (current, total, _) in
                DispatchQueue.main.async {
                    self.progressView.progress = CGFloat(current) / CGFloat(total)
                }
            }) { (image, _, _, _) in
                self.calculateImageViewFrame(image!)
                self.imageView.image = image
                self.progressView.isHidden = true
            }
        }
    }
    
    private func calculateImageViewFrame(_ image: UIImage) {
        // 1.计算位置
        let imageWidth = UIScreen.main.bounds.width
        let imageHeight = imageWidth / image.size.width * image.size.height
        
        // 2.设置frame
        imageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        // 3.设置contentSize, 否则不能滚动
        scrollView.contentSize = CGSize(width: imageWidth, height: imageHeight)
        
        // 4.判断是长图还是短图
        if imageHeight < UIScreen.main.bounds.height { // 短图
            // 设置偏移量
            let topInset = (UIScreen.main.bounds.height - imageHeight) * 0.5
            scrollView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        } else { // 长图
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    private func bigImageURL(_ picUrl: URL) -> URL {
        let middleURLString = picUrl.absoluteString.replacingOccurrences(of: "thumbnail", with: "bmiddle")
        return URL(string: middleURLString)!
    }
}
