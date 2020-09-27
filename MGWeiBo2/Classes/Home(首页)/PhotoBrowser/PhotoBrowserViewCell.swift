//
//  PhotoBrowserViewCell.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/27.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit
import SDWebImage
class PhotoBrowserViewCell: UICollectionViewCell {
    var picUrl: URL? {
        didSet {
            // 1.nil值校验
            guard let picUrl = picUrl else {
                return
            }
            
            // 2.取出image对象
            imageView.sd_setImage(with: picUrl) { (image: UIImage?, err: Error?, type: SDImageCacheType, url: URL?) in
                
//                self.indicatorView.stopAnimating()
                
                guard let image = image else {
                    return
                }
                
                let width = UIScreen.main.bounds.size.width
                // 放大了多少倍
                let height = width / image.size.width * image.size.height
                
                
                var y: CGFloat = 0
                if height > UIScreen.main.bounds.size.height {
                    y = 0
                } else {
                    y = (UIScreen.main.bounds.size.height - height) * 0.5
                    
                }
                self.imageView.frame = CGRect(x: 0, y: y, width: width, height: height)
                // 设置图片
                self.imageView.image = image
            }
        }
    }
    
    private lazy var scrollView: UIScrollView = UIScrollView()
    private lazy var imageView: UIImageView = UIImageView()
    
    // 重写init方法，初始化数据
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PhotoBrowserViewCell {
    private func setupUI() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.frame = contentView.bounds
    }
}
