//
//  EmoticonViewCell.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/24.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class EmoticonViewCell: UICollectionViewCell {
    var emoticon: Emoticon? {
        didSet {
            guard let emoticon = emoticon else {
                return
            }
            
            // 设置button属性
            emojiBtn.setImage(UIImage(contentsOfFile: emoticon.pngPath ?? ""), for: .normal)
            emojiBtn.setTitle(emoticon.emojiCode, for: .normal)
        }
    }
    
    var emojiBtn: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmoticonViewCell {
    private func setupUI() {
        contentView.addSubview(emojiBtn)
        emojiBtn.frame = contentView.bounds
        
        // 设置emojiBtn属性
        emojiBtn.isUserInteractionEnabled = false
        emojiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
}
