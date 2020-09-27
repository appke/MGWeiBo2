//
//  PhotoBrowserController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/27.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class PhotoBrowserController: UIViewController {

    let indexPath: NSIndexPath
    let picUrls: [URL]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
    }
}
