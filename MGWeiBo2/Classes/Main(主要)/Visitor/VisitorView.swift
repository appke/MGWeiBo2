//
//  VisitorView.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/10.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    /// 快速通过类方法创建，方法名==类名
    class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
}
