//
//  ProgressView.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/27.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    var progress : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 1.获取参数
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let r = min(rect.width, rect.height) * 0.5 - 6
        let start = CGFloat(-Double.pi / 2)
        let end = start + progress * 2 * CGFloat(Double.pi)
        
        /**
         参数：
         1. 中心点
         2. 半径
         3. 起始弧度
         4. 截至弧度
         5. 是否顺时针
         */
        
        // 2.根据进度画出中间的圆
        let path = UIBezierPath(arcCenter: center, radius: r, startAngle: start, endAngle: end, clockwise: true)
        path.addLine(to: center)
        path.close()
        UIColor(white: 1.0, alpha: 0.7).setFill()
        path.fill()
        
        // 3.画出边线
        let rEdge = min(rect.width, rect.height) * 0.5 - 2
        let endEdge = start + 2 * CGFloat(Double.pi)
        let pathEdge = UIBezierPath(arcCenter: center, radius: rEdge, startAngle: start, endAngle: endEdge, clockwise: true)
        UIColor(white: 1.0, alpha: 0.5).setStroke()
        pathEdge.stroke()
    }
}
