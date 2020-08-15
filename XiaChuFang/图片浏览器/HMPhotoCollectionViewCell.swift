//
//  HMPhotoCollectionViewCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/2.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMPhotoCollectionViewCell: UICollectionViewCell {
    lazy var my_imageView: UIImageView = {
        let my_imageView = UIImageView()
        my_imageView.isUserInteractionEnabled = true
        
        // 添加手势
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(didtap))
        my_imageView.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(didtap2(gesture:)))
        tap2.numberOfTapsRequired = 2
        my_imageView.addGestureRecognizer(tap2)
        tap1.require(toFail: tap2)
        
        return my_imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: YYScreenWidth, height: YYScreenHeigth))
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 0.5
        scrollView.backgroundColor = .clear
        
        scrollView.addSubview(my_imageView)
        return scrollView
    }()
    
    var imageUrl: String?
    
    var imageRatio: CGFloat?{
        didSet{
            // 设置图片和frame
            let height = YYScreenWidth * imageRatio!
            let y = (YYScreenHeigth - height) / 2
            
            my_imageView.frame = CGRect(x: 0, y: y, width: YYScreenWidth, height: height)
            my_imageView.kf.setImage(with: URL(string: imageUrl!))
            
            contentView.addSubview(scrollView)
        }
    }
    
    
    // 单击退出
    @objc func didtap(){
        NotificationCenter.default.post(Notification.init(name: NSNotification.Name(rawValue: "tapImage")))
    }
    
    // 双击放大比例
    var scale: CGFloat = 1.5
    
    // 双击放大
    @objc func didtap2(gesture: UIGestureRecognizer){
        if scale <= 2.25{
            scrollView.setZoomScale(scale, animated: true)
            scale = scale * scale
        }else{
            scale = 1.5
            scrollView.setZoomScale(1, animated: true)
        }
    }
}
    
extension HMPhotoCollectionViewCell: UIScrollViewDelegate{
    
    // 告诉scrollView哪一个view要缩放
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return my_imageView
    }
    
    // 缩放的时候调整坐标
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
        let offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
        my_imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY);
        
    }
    
}
    
