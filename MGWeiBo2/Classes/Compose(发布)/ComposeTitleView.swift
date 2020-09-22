//
//  ComposeTitleView.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/23.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTitleView: UIView {

    private lazy var titleLabel: UILabel = UILabel()
    private lazy var screenNmaeLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ComposeTitleView {
    private func setupUI() {
        // 添加控件
        addSubview(titleLabel)
        addSubview(screenNmaeLabel)
        
        // 设置frame
        titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
        }
        screenNmaeLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(3)
        }
        
        // 设置属性
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        screenNmaeLabel.font = UIFont.systemFont(ofSize: 12)
        screenNmaeLabel.textColor = .lightGray
        
        // 设置标题
        titleLabel.text = "发微博"
        screenNmaeLabel.text = UserAccountViewModel.shared.account?.screen_name
    }
}
