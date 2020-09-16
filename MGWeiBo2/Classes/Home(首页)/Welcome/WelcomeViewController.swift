//
//  WelcomeViewController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/16.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconViewBottonConst: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let profileUrlString = UserAccountViewModel.shared.account?.avatar_large
        let url = URL(string: profileUrlString ?? "")
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default"), options: [], completed: nil)
        
        // 1.改变约束值
        iconViewBottonConst.constant = UIScreen.main.bounds.size.height - 200
        
        // 2.执行动画
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }){ (Bool) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
}
