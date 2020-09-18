//
//  HomeViewCell.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/18.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    //MARK: 自定义属性
    var viewModel: StatusViewModel? {
        didSet {
            // 1.nil值校验
            guard let viewModel = viewModel else {
                return
            }
            
            // 2.设置图形
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
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 正文宽度约束？
    }
}
