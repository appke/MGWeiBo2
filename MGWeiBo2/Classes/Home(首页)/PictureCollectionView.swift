//
//  PictureCollectionView.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/21.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit
import SDWebImage

class PictureCollectionView: UICollectionView {

    var picURLs: [URL] = [URL]() {
        didSet {
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dataSource = self
        self.delegate = self
    }
}

//MARK:- UICollectionView数据源代理
extension PictureCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as! PictureCell
        cell.picURL = picURLs[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userInfo: [String: Any] = [ShowPhotoBrowserIndexKey: indexPath, ShowPhotoBrowserUrlsKey: picURLs]
        // 发送弹出通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ShowPhotoBrowserNote), object: self, userInfo: userInfo)
    }
}


//MARK:- PhotoBrowserPresentedDelegate
extension PictureCollectionView: PhotoBrowserPresentedDelegate {
    // 1.提供弹出的imageView
    func imageForPresent(indexPath : NSIndexPath) -> UIImageView {
        let imageView = UIImageView()
        
        // 获取image图片
        let picUrl = picURLs[indexPath.row]
        
        // imageView的属性
        imageView.sd_setImage(with: picUrl, completed: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    // 2.提供弹出的imageView的frame
    func startRectForPresent(indexPath : NSIndexPath) -> CGRect {
        // 获取cell
        guard let cell = self.cellForItem(at: indexPath as IndexPath) as? PictureCell else {
            return .zero
        }
        
        // 获取cell的frame 相对整个界面的frame
        let startFrame = self.convert(cell.frame, to: UIApplication.shared.keyWindow)
        return startFrame
    }
    
    // 3.提供弹出后imageView的frame
    func endRectForPresent(indexPath : NSIndexPath) -> CGRect {
        // 获取该位置的cell对象
        guard let cell = self.cellForItem(at: indexPath as IndexPath) as? PictureCell else {
            return .zero
        }
        // 拿到被点击的图片
        let image = cell.picImageView.image!
        
        // 计算结束后的frame
        let imageW = UIScreen.main.bounds.size.width
        let imageH = imageW / image.size.width * image.size.height
        
        var imageY: CGFloat = 0
        if imageH > UIScreen.main.bounds.height {
            imageY = 0
        } else {
            imageY = (UIScreen.main.bounds.height - imageH) * 0.5
        }
        
        return CGRect(x: 0, y: imageY, width: imageW, height: imageH)
    }
}



/// 自定义cell
class PictureCell : UICollectionViewCell {
    
    @IBOutlet weak var picImageView: UIImageView!
    var picURL: URL? {
        didSet {
            // nil值校验
            guard let picURL = picURL else {
                return
            }
            
            picImageView.sd_setImage(with: picURL, placeholderImage: UIImage(named: "timeline_card_middle_background"), options: [], context: nil)
        }
    }
}
