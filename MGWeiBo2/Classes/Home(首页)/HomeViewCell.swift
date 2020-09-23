//
//  HomeViewCell.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/18.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin: CGFloat = 15
private let itemMargin: CGFloat = 10

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var pictureView: PictureCollectionView!
    @IBOutlet weak var retweetedBgView: UIView!
    @IBOutlet weak var bottomToolView: UIView!
    @IBOutlet weak var retweetedContentLabel: UILabel!
    
    @IBOutlet weak var conetentLabelWConst: NSLayoutConstraint!
    
    //MARK:拖线约束
    @IBOutlet weak var picViewWConst: NSLayoutConstraint!
    @IBOutlet weak var picViewHConst: NSLayoutConstraint!
    
    @IBOutlet weak var retweetedLabelBottomConst: NSLayoutConstraint!
    @IBOutlet weak var pictureViewBottomConst: NSLayoutConstraint!
    
    //MARK: 自定义属性
    var viewModel: StatusViewModel? {
        didSet {
            // 1.nil值校验
            guard let viewModel = viewModel else {
                return
            }
            
            // 2.设置用户图像
            iconView.sd_setImage(with: viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default"), options: [], context: nil);
            
            // 3.设置认证图标
            verifiedView.image = viewModel.verifiedImage
            
            // 4.用户昵称
            screenNameLabel.text = viewModel.status?.user?.screen_name
            screenNameLabel.textColor = viewModel.vipImage == nil ? .black : .orange
            
            // 5.设置vip
            vipView.image = viewModel.vipImage
            
            // 6.设置时间
            timeLabel.text = viewModel.createAtText
            
            // 7.设置来源
            sourceLabel.text = viewModel.sourceText
            
            // 8.正文
            contentLabel.text = viewModel.status?.text
            
            // 9.计算配图视图宽/高
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWConst.constant = picViewSize.width
            picViewHConst.constant = picViewSize.height
            
            // 10.设置配图数据
            pictureView.picURLs = viewModel.picURLs
            
            // 11.设置转发微博的正文
            if viewModel.status?.retweeted_status != nil {
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name,
                    let retweetedText = viewModel.status?.retweeted_status?.text {
                    retweetedContentLabel.text = "@" + "\(screenName): " + retweetedText
                    
                    // 设置转发正文距离顶部约束
                    retweetedLabelBottomConst.constant = 10
                }
                // 设置背景显示
                retweetedBgView.isHidden = false
            } else {
                // 1.设置转发文字
                retweetedContentLabel.text = nil
                // 2.设置背景显示
                retweetedBgView.isHidden = true
                // 3.设置转发正文距离顶部约束
                retweetedLabelBottomConst.constant = 0
            }
            
            // 12.计算cell高度
            if viewModel.cellHeight == 0 {
                layoutIfNeeded()
                viewModel.cellHeight = bottomToolView.frame.maxY
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 正文宽度约束？
        conetentLabelWConst.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        // 设置collectionView的尺寸
        let layout = pictureView.collectionViewLayout as! UICollectionViewFlowLayout
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
//        layout.minimumInteritemSpacing = itemMargin
//        layout.minimumLineSpacing = itemMargin
//        layout.sectionInset = UIEdgeInsets.zero
    }
}

extension HomeViewCell {
    private func calculatePicViewSize(count: Int) -> CGSize {
        
        if count == 0 {
            pictureViewBottomConst.constant = 0
            return CGSize.zero
        }
        
        // 有配图需要该约束有值
        pictureViewBottomConst.constant = 10
        
        // 计算imageView宽高
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        
        // 4张配图 
        if count == 4 {
            let picViewWH = 2 * imageViewWH + itemMargin
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        // 其它配图
        let rows = CGFloat((count - 1) / 3 + 1)
        let picViewW = UIScreen.main.bounds.width - 2 * edgeMargin
        let picViewH = imageViewWH * rows + itemMargin * (rows - 1)
        
        return CGSize(width: picViewW, height: picViewH + 1)
    }
}
