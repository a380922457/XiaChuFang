//
//  HMHomeRecCollectionViewCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/4.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import Kingfisher
import KingfisherWebP

open class HMHomeRecCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoHeight: NSLayoutConstraint!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var collecionButton: UIButton!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var collectNumber: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var model: HMRecModel?{
        didSet{
            // 设置图片
            let url = URL(string: "http://i2.chuimg.com/" + model!.image!.ident!)

            photo.kf.setImage(with: url, options: [.processor(WebPProcessor()), .cacheSerializer(WebPSerializer.default)])
            
            // 设置描述
            textLabel.text = model!.title_1st
            
            // 设置作者头像和名字
            authorName.text = model!.authorName
            authorButton.kf.setBackgroundImage(with: URL(string: model!.authorImage), for: .normal)
            authorButton.clipsToBounds = true
            
            // 设置收藏数
            collectNumber.text = model!.extra!.is_video_recipe! ? model?.extra?.extra_icon_value : model?.extra?.n_collects
            
            // 设置是爱心还是大拇指
            let name = model!.extra!.is_video_recipe! ? "common_like" : "dish_collect"
            collecionButton.setImage(UIImage.init(named: name), for: .normal)
            
            // 显示playButton
            playButton.isHidden = !model!.extra!.is_video_recipe!
            
            // 动态设置imageview高度
            photoHeight.constant = min(photo.frame.size.width * model!.image!.ratio, 200)
            
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }

}
