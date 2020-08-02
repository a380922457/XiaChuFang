//
//  HMCollectionViewFlowLayout.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/7/31.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

open class HMCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var model: HMDishModel!{
        didSet{
            minimumInteritemSpacing = 5
            minimumLineSpacing = 5
            
            var width: CGFloat = 0
            var height: CGFloat = 0
            if model.extra_images?.count == 0{
                width = 280
                height = width * (model.image!.original_height! / model.image!.original_width!)
            }else{
                width = (YYScreenWidth - 10 - 20) / 3
                height = width
            }
            
            itemSize = CGSize(width: width, height: height)
        }
    }
    
    
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attrs = super.layoutAttributesForElements(in: rect)
        
        // 拦截原方法，修改单张图片情况下的原点坐标
        for attr: UICollectionViewLayoutAttributes in attrs!{
            if attr.indexPath.row == 0 && model.extra_images?.count == 0{
                attr.frame.origin = CGPoint(x: 0, y: 0)
            }
        }
        
        return attrs
    }
    
}
