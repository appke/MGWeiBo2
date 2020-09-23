//
//  PicPickerCollectionView.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/23.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class PicPickerCollectionView: UICollectionView {
    
    var images: [UIImage] = [UIImage]() {
        didSet {
            reloadData()
        }
    }
    private let picPickerCell = "picPickerCell"
    private let edgeMargin: CGFloat = 15
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // 设置属性
        dataSource = self
        register(UINib(nibName: "PicPickerViewCell", bundle: nil), forCellWithReuseIdentifier: picPickerCell)
        
        // 设置布局
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (UIScreen.main.bounds.width - 4 * edgeMargin) / 3
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumInteritemSpacing = edgeMargin
        layout.minimumLineSpacing = edgeMargin
        layout.sectionInset = UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: edgeMargin, right: edgeMargin)
    }
}

extension PicPickerCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picPickerCell, for: indexPath) as! PicPickerViewCell
        cell.backgroundColor = .red
        cell.image = indexPath.row <= images.count - 1 ? images[indexPath.row] : nil
        return cell
    }
}
