//
//  HMHomeRecColleciontViewLayout.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/4.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMHomeRecColleciontViewLayout: UICollectionViewLayout {

    var models: [HMRecModel]?{
        didSet{
            let inset: CGFloat = 10
            let WIDTH = (YYScreenWidth - inset * 3) / 2
            //保存每一列的总高度，这样在布局时，我们可以始终将下一个Item放在最短的列下面
            var colHight = [CGFloat(0), CGFloat(0)]
            
            //itemCount是外界传进来的item的个数 遍历来设置每一个item的布局
            for i in 0 ..< models!.count {
                //设置每个item的位置等相关属性
                let index = IndexPath(row: i, section: 0)
                //创建一个布局属性类，通过indexPath来创建
                let attr = UICollectionViewLayoutAttributes(forCellWith: index)

                let hight = min(models![i].image!.ratio * WIDTH, 200) + 100
                //标记最短的列
                var width = 0
                if colHight[0] < colHight[1] {
                    //将新的item高度加入到短的一列
                    colHight[0] = colHight[0] + CGFloat(hight) + inset
                    width = 0
                } else {
                    colHight[1] = colHight[1] + CGFloat(hight) + inset
                    width = 1
                }
                
                //设置item的位置
                attr.frame = CGRect(x: inset + (inset + WIDTH) * CGFloat(width),
                                      y: colHight[width] - CGFloat(hight) - inset,
                                      width: WIDTH,
                                      height: CGFloat(hight))
                attrs.append(attr)
            }
            totalHeight = max(colHight[0], colHight[1])
            totalWidth = WIDTH
        }
    }
    
    var totalHeight: CGFloat?
    var totalWidth: CGFloat?
    
    lazy var attrs = [UICollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize{
        let size = CGSize(width: totalWidth ?? YYScreenHeigth, height: (totalHeight ?? 1000) + 100)
        
        return size
    }
    
    override func prepare() {
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrs
    }

}
