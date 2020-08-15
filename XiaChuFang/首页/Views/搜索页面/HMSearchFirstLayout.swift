//
//  HMSearchFirstLayout.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/6.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMSearchFirstLayout: UICollectionViewLayout {
    
    lazy var header0: UIView = {
        // 添加第一个header
        let header = UIView(frame: CGRect(x: 0, y: 0, width: YYScreenWidth, height: 60))
        
        // 设置左边label
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 80, height: 40))
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "最近搜索"
        
        // 设置右边按钮
        let clearButton = UIButton.init(frame: CGRect(
            x: Int(YYScreenWidth) - 40 - 20, y: 20, width: 40, height: 40))
        clearButton.setTitle("清空", for: .normal)
        clearButton.setTitleColor(.lightGray, for: .normal)
        clearButton.titleLabel?.font = .systemFont(ofSize: 16)
        clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
        
        header.addSubview(label)
        header.addSubview(clearButton)
        collectionView?.addSubview(header)

        return header
    }()
    
    lazy var header1: UIView = {
        // 添加第二个header
        let header = UIView()
        
        // 设置左边label
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 80, height: 40))
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "流行搜索"
        header.addSubview(label)
        collectionView?.addSubview(header)

        return header
    }()
    
    
    var attrs0 = [UICollectionViewLayoutAttributes]()
    var attrs1 = [UICollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: YYScreenWidth, height: 600)
    }
        
    var recentSearchs: [String]?{
        didSet{
            calcAttr(searchs: recentSearchs ?? [String](), isRencent: true)
        }
    }
    
    var popularSearchs: [String]?{
        didSet{
            calcAttr(searchs: popularSearchs!, isRencent: false)
        }
    }
    
    var maxRencentY: Int?
        
    func calcAttr(searchs: [String], isRencent: Bool){
        let gap = 10, leftEdge = 20, buttonHeight = 30
        
        var x = leftEdge, y = 60
        if isRencent {attrs0.removeAll()} else {attrs1.removeAll()}
        
        if !isRencent{y += maxRencentY!}
        
        for i in 0 ..< searchs.count {
            //设置每个item的位置等相关属性
            let index = IndexPath(row: i, section: isRencent ? 0 : 1)
            let attr = UICollectionViewLayoutAttributes(forCellWith: index)
             
            let width = Int(searchs[i].sizeWithText(font: UIFont.systemFont(ofSize: 20)).width) + 20
             
            // 如果超过屏幕宽度了，就换行
            if x + width > Int(YYScreenWidth) - leftEdge{
                 x = leftEdge
                // 最近只能有两行
                 if y + buttonHeight + gap > 100 && isRencent{
                    break
                 }
                 y = y + buttonHeight + gap
            }
             
            attr.frame = CGRect(x: x, y: y, width: width, height: buttonHeight)
            x = x + gap + width
            if isRencent{
                attrs0.append(attr)
            }else{
                attrs1.append(attr)
            }
             
         }
        
         if isRencent {
            maxRencentY = y + 20
            // 搞一下，懒加载
            print(header0)
         }else{
            // 动态修改header1的frame，因为最近搜索可能会清空
            header1.frame = CGRect(x: 0, y: maxRencentY!, width: Int(YYScreenWidth), height: 60)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrs0 + attrs1
    }
    
    // 点击清空按钮，发送通知
    @objc func clear(){
        // 重新计算布局
        recentSearchs = nil
        calcAttr(searchs: popularSearchs!, isRencent: false)

        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "clear")))
    }
    
}
