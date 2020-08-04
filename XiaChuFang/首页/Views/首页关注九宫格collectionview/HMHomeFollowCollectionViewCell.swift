//
//  HMHomeFollowCollectionViewCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/7/31.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

open class HMHomeFollowCollectionViewCell: UICollectionViewCell {
    var dish: HMDishModel?
    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init()
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
}
