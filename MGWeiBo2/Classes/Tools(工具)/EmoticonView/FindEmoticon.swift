//
//  FindEmoticon.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/25.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class FindEmoticon: NSObject {
    
    //MARK: 设计单例对象
    static let share: FindEmoticon = FindEmoticon()
    
    lazy var manager: EmoticonManager = EmoticonManager()
    
    func findAttrString(text: String?, font: UIFont) -> NSMutableAttributedString? {
        
        guard let text = text else {
            return nil
        }
        
        // 1.创建规则
        let pattern = "\\[.*?\\]"
        
        // 2.利用规则创建一个正则表达式对象
        guard let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive) else {
            return nil
        }
        
        // 3.匹配结果
        let results = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
        
        // 4.创建一个属性字符串
        let attrMStr = NSMutableAttributedString(string: text)
        // for result in results {
        for result in results.reversed() {
            // 4.1.取出匹配结果的chs
            let chs = (text as NSString).substring(with: result.range)
            
            // 4.2.查找chs对应的pngPath
            guard let pngPath = findPngPath(chs: chs) else {
                // 没找到，匹配下一个表情
                continue
            }
            
            // 4.3.根据路径创建属性字符串
            let attachment = NSTextAttachment()
            attachment.image = UIImage(contentsOfFile: pngPath)
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let emoAttrStr = NSAttributedString(attachment: attachment)
            
            // 4.4.将之前字符串中chs替换成表情
            attrMStr.replaceCharacters(in: result.range, with: emoAttrStr)
        }
        
        return attrMStr
    }
    
    private func findPngPath(chs: String) -> String? {
        // 遍历所有表情,返回chs对应的pngPath
        for package in manager.packages {
            for emoticon in package.emoticons {
                if emoticon.chs == chs {
                    return emoticon.pngPath
                }
            }
        }
        return nil
    }
}
