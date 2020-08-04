//
//  HMPhotoCollectionViewCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/2.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMPhotoCollectionViewCell: UICollectionViewCell {
    var dish: HMDishModel?
    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init()
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        
        // 添加单击手势
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(didtap))
        imageView.addGestureRecognizer(tap1)

        // 添加双击手势
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(didDoubleTap(tap:)))
        tap2.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap2)
        tap1.require(toFail: tap2)

        // 添加上滑下滑手势
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(didSwipe))
        swipe.direction = UISwipeGestureRecognizer.Direction(rawValue: UISwipeGestureRecognizer.Direction.up.rawValue | UISwipeGestureRecognizer.Direction.down.rawValue)
        imageView.addGestureRecognizer(swipe)

         // 添加双指收缩
        let pinch = UIPinchGestureRecognizer.init(target: self, action: #selector(didPinch(pinch:)))
        imageView.addGestureRecognizer(pinch)
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    
    @objc func didPinch(pinch: UIPinchGestureRecognizer){
        var scale = pinch.scale
        scale = scale > 1 ? 1.1 : 0.9
        imageView.transform = imageView.transform.scaledBy(x: scale, y: scale)
    }
    
    @objc func didSwipe(){
        print("didSwipe")
    }
    
    @objc func didtap(){
        print("didtap")
    }
    
    @objc func didDoubleTap(tap: UITapGestureRecognizer){
        imageView.transform = imageView.transform.scaledBy(x: 1.2, y: 1.2)

    }
    
}
