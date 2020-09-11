//
//  VisitorView.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/10.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    /// 快速通过类方法创建，方法名==类名
    class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
    
    func addRotation() { 
        // 创建旋转动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")

        // 设置动画属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 4 //转1圈的时间
        rotationAnim.isRemovedOnCompletion = false //切换之后动画会移除

        // 将动画添加到layer中
        rotationView.layer.add(rotationAnim, forKey: nil)
    }
    
    //MARK: 自定义函数
    func setupVisitorInfo(iconName: String, title: String) {
        
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.isHidden = true
    }
    
}
