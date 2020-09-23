//
//  EmoticonViewController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/23.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

class EmoticonViewController: UIViewController {
    
//    /// 保存所有组数据
//    var packages: [XMGKeyboardPackage] = XMGKeyboardPackage.loadEmotionPackages()
//
//    /// 点击表情回调闭包
//    var callback: (_ emoticon: XMGKeyboardEmoticon)->()
    
//    init(callback: @escaping (_ emoticon: XMGKeyboardEmoticon)->()) {
//        self.callback = callback
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    private lazy var toolBar: UIToolbar = {
//       let tb = UIToolbar()
//        return tb
//    }()
    
    lazy private var collectionView: UICollectionView = UICollectionView()
    lazy private var toolBar: UIToolbar = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        prepareForCollectionView()
        
        prepareForToolBar()
    }
}

//MARK:- UI界面相关
extension EmoticonViewController {
    private func setupUI() {
        // 1.添加子控件
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        // 2.设置子控件frame
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String : Any] = ["cView": collectionView, "tBar": toolBar]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[cView]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[cView]-[tBar(49)]-0-|", options: [], metrics: nil, views: views)
        
        view.addConstraints(cons)
    }
    
    private func prepareForCollectionView() {
        collectionView.backgroundColor = UIColor.white
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "keyboardCell")
    }
    
    private func prepareForToolBar() {
        toolBar.tintColor = .lightGray
        
        var items = [UIBarButtonItem]()
        var index = 0
        for title in ["最近", "默认", "Emoji", "浪小花"] {
            // 1.创建item
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(itemClick(_:)))
            item.tag = index
            index += 1
            items.append(item)
            
            // 2.弹簧
            let flexItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            items.append(flexItem)
        }
        
        items.removeLast()
        // 将item添加到toolbar上
        toolBar.items = items
    }
    
    @objc private func itemClick(_ item: UIBarButtonItem) {
        // 1.创建indexPath
        let indexPath = IndexPath(item: 0, section: item.tag)
        // 2.滚动到指定的indexPath
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}

//MARK:- 事件监听
extension EmoticonViewController {
    
}

//extension EmoticonViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return packages.count
//    }
//
//    // 告诉系统每组多少个
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return packages[section].emoticons?.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // 1.取出cell
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "keyboardCell", for: indexPath) as! KeyboardEmoticonCell
//
////        cell.backgroundColor = (indexPath.item % 2 == 0) ? UIColor.red: UIColor.purple
//        // 2.设置数据
////        cell.emoticon = packages[indexPath.section].emoticons![indexPath.item]
//        let package = packages[indexPath.section]
//        cell.emoticon = package.emoticons![indexPath.item]
//
//        // 3.返回cell
//        return cell
//    }
//}

//extension EmoticonViewController: UICollectionViewDelegate {
//    /// 监听表情点击
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let package = packages[indexPath.section]
//        let emoticon = package.emoticons![indexPath.item]
//
//        // 每使用一次就+1
//        emoticon.count += 1
//
//        // 判断是否是删除按钮
//        if !emoticon.isRemoveButton{
//            // 将当前点击的表情添加到最近组中
//            packages[0].addFavoriteEmoticon(emoticon: emoticon)
//        }
//        callback(emoticon)
//    }
//}


class KeyboardEmoticonLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        // 1.计算cell宽度
        let itemWH = UIScreen.main.bounds.width / 7
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
        
        // 2.设置collectionView
        collectionView?.bounces = false
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        
        // 3.设置上下内边距，不让它上下拉伸～有空隙
        let insetMargin = (collectionView!.bounds.height - 3 * itemWH) * 0.5
        collectionView?.contentInset = UIEdgeInsets(top: insetMargin, left: 0, bottom: insetMargin, right: 0)
    }
}
