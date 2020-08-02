//
//  HMPhotoCollectionViewLayout.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/2.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMPhotoCollectionViewLayout: UICollectionViewLayout {
    var model: HMDishModel?
    var attrs = [UICollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: CGFloat(model!.imageUrls.count) * YYScreenWidth, height: collectionView!.frame.size.height)
    }
    
    override func prepare() {
        super.prepare()

        for (i, ratio) in model!.imageRatios.enumerated(){
            let attr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: i, section: 0))
            let height = YYScreenWidth * CGFloat(ratio!)
            let x = CGFloat(attr.indexPath.row) * YYScreenWidth
            let y = (collectionView!.frame.size.height - height) / 2
            attr.frame = CGRect(x: x, y: y, width: YYScreenWidth, height: height)
            attrs.append(attr)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrs
    }
}
