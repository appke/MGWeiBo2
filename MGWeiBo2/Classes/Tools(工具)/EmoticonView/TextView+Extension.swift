//
//  TextView+Extension.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/25.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

extension UITextView {
    // 获取textView属性字符串，对应的表情字符串
    func getEmoticonString() -> String {
        // NSAttachment表情 + NSFont文字 Range
        // 1.获取属性字符串
        let attrMStr = NSMutableAttributedString(attributedString: attributedText)
        
        // 2.遍历属性字符串
        let range = NSRange(location: 0, length: attrMStr.length) //把整个字符串都交给它
        attrMStr.enumerateAttributes(in: range, options: []) { (dict, range, _) in
            if let attachment = dict[NSAttributedString.Key(rawValue: "NSAttachment")] as? EmoticonAttachment {
                attrMStr.replaceCharacters(in: range, with: attachment.chs!)
            }
        }
        
        // 3.取出字符串
        return attrMStr.string
    }
    
    /// 给textView插入表情
    func insertEmoticon(_ emoticon: Emoticon) {
        // 1.空白表情
        if emoticon.isEmpty {
            return
        }
        
        // 2.删除按钮
        if emoticon.isRemove {
            
            deleteBackward()
            return
        }
        
        // 3.emoji表情
        if let emojiCode = emoticon.emojiCode {
            //            // 获取光标所在位置
            //            let textRange = selectedTextRange!
            //            // 替换emoji表情
            //            replace(textRange, withText: emojiCode)
            insertText(emojiCode)
            return
        }
        
        // 4.png表情，图文混排
        // 图片路径 –≥ 创建属性字符串
        let attachment = EmoticonAttachment()
        attachment.chs = emoticon.chs
        attachment.image = UIImage(contentsOfFile: emoticon.pngPath!)
        // 图片太大？太靠上了
        let font = self.font!
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attImageStr = NSAttributedString(attachment: attachment)
        
        // 创建可变字符串
        let attrMStr = NSMutableAttributedString(attributedString: attributedText)
        
        // 获取光标所在位置
        let textRange = selectedRange
        attrMStr.replaceCharacters(in: textRange, with: attImageStr)
        
        // 显示属性字符串
        attributedText = attrMStr
        
        // 重置文字大小
        self.font = font
        
        // 将光标设置为原来位置 + 1
        selectedRange = NSRange(location: textRange.location + 1, length: 0)
    }
}
