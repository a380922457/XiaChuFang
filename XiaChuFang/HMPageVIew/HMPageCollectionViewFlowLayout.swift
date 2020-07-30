//
//  HMPageCollectionViewFlowLayout.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/28.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

open class HMPageCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var offset: CGFloat?
    
    override open func prepare() {
        super.prepare()
        guard let offset = offset else { return }
        collectionView?.contentOffset = CGPoint(x: offset, y: 0)
    }
}
