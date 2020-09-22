//
//  PictureCollectionView.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/21.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class PictureCollectionView: UICollectionView {

    var picURLs: [URL] = [URL]() {
        didSet {
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dataSource = self
    }
}

extension PictureCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as! PictureCell
        cell.picURL = picURLs[indexPath.item]
        
        return cell
    }
}



/// 自定义cell
class PictureCell : UICollectionViewCell {
    
    @IBOutlet weak var picImageView: UIImageView!
    
    var picURL: URL? {
        didSet {
            // nil值校验
            guard let picURL = picURL else {
                return
            }
            
            picImageView.sd_setImage(with: picURL, placeholderImage: UIImage(named: "timeline_card_middle_background"), options: [], context: nil)
        }
    }
}
