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
                addPhotoBtn.setBackgroundImage(image, for: .normal)
                addPhotoBtn.isUserInteractionEnabled = false
                delPhotoBtn.isHidden = false
            } else {
                addPhotoBtn.setBackgroundImage(UIImage(named: "compose_pic_add_background"), for: .normal)
                addPhotoBtn.isUserInteractionEnabled = true
                delPhotoBtn.isHidden = true
            }
        }
    }

    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var delPhotoBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func addPhotoClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name.init(PicPickerPhotoNote), object: nil)
    }
    
    
    @IBAction func delPhotoClick(_ sender: Any) {
        
    }
}
