//
//  ComposeTextView.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/23.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {
    
    lazy private var placeholderLabel: UILabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
}

extension ComposeTextView {
    private func setupUI() {
        addSubview(placeholderLabel)
        
        // 设置frame
        placeholderLabel.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
        }

        // 设置属性
        placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        placeholderLabel.textColor = .lightGray
        placeholderLabel.text = "分享新鲜事..."
        
        // 设置内边距
        textContainerInset = UIEdgeInsets(top: 10, left: 6, bottom: 0, right: 6)
    }
}
