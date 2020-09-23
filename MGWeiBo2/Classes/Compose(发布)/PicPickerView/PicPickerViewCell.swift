//
//  PicPickerViewCell.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/23.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class PicPickerViewCell: UICollectionViewCell {

    var image: UIImage? {
        didSet {
            if image != nil {
                imageView.image = image //按钮背景图像压缩
                addPhotoBtn.isUserInteractionEnabled = false
                delPhotoBtn.isHidden = false
            } else {
                imageView.image = nil
                addPhotoBtn.isUserInteractionEnabled = true
                delPhotoBtn.isHidden = true
            }
        }
    }

    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var delPhotoBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func addPhotoClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name.init(PicPickerAddPhotoNote), object: nil)
    }
    
    
    @IBAction func delPhotoClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: PicPickerDelPhotoNote), object: imageView.image)
    }
}
