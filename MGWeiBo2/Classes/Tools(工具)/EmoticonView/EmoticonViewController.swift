//
//  EmoticonViewController.swift
//  MGWeiBo2
//
//  Created by MGBook on 2020/9/23.
//  Copyright © 2020 穆良. All rights reserved.
//

import UIKit

private let EmoticonCellId = "EmoticonCellId"

class EmoticonViewController: UIViewController {
    
    lazy private var manager = EmoticonManager()
    
    lazy private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: EmoticonCollectionViewLayout())
    lazy private var toolBar: UIToolbar = UIToolbar()
    
    /// 点击表情回调闭包
    var callback: (_ emoticon: Emoticon)->()
    
    init(emoticonCallBack: @escaping (_ emoticon: Emoticon)->()) {
        self.callback = emoticonCallBack
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EmoticonViewCell.self, forCellWithReuseIdentifier: EmoticonCellId)
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
        // 2.滚动到指定的indexPath,滚到最左边
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}

//MARK:- Collection的数据源和代理方法
extension EmoticonViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }

    // 告诉系统每组多少个
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let emoticons = manager.packages[section].emoticons
        return emoticons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonCellId, for: indexPath) as! EmoticonViewCell
        //cell.backgroundColor = (indexPath.item % 2 == 0) ? UIColor.red: UIColor.purple
        
        // 2.设置数据
        let package = manager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.item]
        cell.emoticon = emoticon

        // 3.返回cell
        return cell
    }
    
    /// 监听表情点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1. 取出表情
        let package = manager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.item]

        // 2.插入到最近分组中
        insertRecentlyEmoticon(emoticon)
        
        // 3.将表情回调给外面控制器
        callback(emoticon)
    }
    
    private func insertRecentlyEmoticon(_ emoticon: Emoticon) {
        // 1.空白、删除按钮,不需要插入
        if emoticon.isEmpty || emoticon.isRemove {
            return
        }
        
        // 2.删除一个表情
        if manager.packages.first!.emoticons.contains(emoticon) { //最近表情中存在
            let index = manager.packages.first!.emoticons.firstIndex(of: emoticon)!
            manager.packages.first?.emoticons.remove(at: index)
        } else {
            //
            manager.packages.first?.emoticons.remove(at: 19)
        }
        
        // 3.将emoticon插入到最近分组中，永远保持
        manager.packages.first?.emoticons.insert(emoticon, at: 0)
    }
}


class EmoticonCollectionViewLayout: UICollectionViewFlowLayout {
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
        
        // 3.设置上下内边距，上下布局合理，等高
        let insetMargin = (collectionView!.bounds.height - 3 * itemWH) / 4
        collectionView?.contentInset = UIEdgeInsets(top: insetMargin, left: 0, bottom: insetMargin, right: 0)
    }
}
