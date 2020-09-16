//
//  MBProgressHUD-Extension.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/15.
//  Copyright © 2020 穆良. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    
    class func show() {
        let view = UIApplication.shared.windows.last!
        MBProgressHUD.showAdded(to: view, animated: true)
    }

    
    
    class func show(_ text: String, icon: String, view: UIView?) {
        
        let view = view ?? UIApplication.shared.windows.last
        
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.label.text = text
        hud.customView = UIImageView.init(image: UIImage(named: "MBProgressHUD.bundle/\(icon)"))
        hud.mode = .customView
        
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 0.7)
    }
    
    /// 显示错误信息
    class func showError(error: String, view: UIView) {
        show(error, icon: "error.png", view: view)
    }
    
    class func showSuccess(success: String, view: UIView) {
        show(success, icon: "success.png", view: view)
    }
    
    
    /// 显示一些信息
    class func showMessage(_ message: String, view: UIView?) {
        
        let view = view ?? UIApplication.shared.windows.last
        
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.label.text = message
        hud.removeFromSuperViewOnHide = true
    }
    
    class func showSuccess(success: String) {
        showMessage(success, view: nil)
    }
    
    class func showError(error: String) {
        showMessage(error, view: nil)
    }
    
    class func showMessage(message: String) {
        showMessage(message, view: nil)
    }
    
    class func hideHUDForView(view: UIView?) {
        let view = view ?? UIApplication.shared.windows.last
        hide(for: view!, animated: true)
    }
    
    class func hideHUD() {
        hideHUDForView(view: nil)
    }
}
