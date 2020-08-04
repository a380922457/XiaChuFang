//
//  HMHomeFollowModel.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/7/29.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import Foundation
import HandyJSON

struct HMHomeFollowModel: HandyJSON {
    var dish: HMDishModel?
}


// MARK: -主模型
struct HMDishModel: HandyJSON {
    /// 图片下方话题按钮名称
    var name: String?
    
    /// 创建时间
    var friendly_create_time: String?
    var create_time: String?
    
    /// 作者信息
    var author: HMAuthor?
    
    /// 这个菜谱的url
    var url: String?
    
    /// 正文标题
    var title: String?
    /// 正文
    var desc: String?
    
    var npics: Int?
    var ncomments: Int? // 评论数量
    var n_collects: Int? // 收藏数量
    var ndiggs: Int? // 点赞数量
    
    /// 第一张图片的信息
    var image: HMPhoto?
    
    /// 额外图片
    var extra_images: [HMPhoto]?
    
    /// 计算属性，包含所有图片的url
    var imageUrls: [String?]{
        var imageUrls = [String?]()
        imageUrls.append("http://i2.chuimg.com/" + (image?.ident)!)
        for image: HMPhoto in extra_images!{
            imageUrls.append("http://i2.chuimg.com/" + image.ident!)
        }
        return imageUrls
    }
    
    /// 计算属性，包含所有图片的高宽比例
    var imageRatios: [CGFloat?]{
        var imageRatios = [CGFloat?]()
        imageRatios.append(image?.ratio)
        for image: HMPhoto in extra_images!{
            imageRatios.append(image.ratio)
        }
        return imageRatios
    }
    
    /// 最近评论
    var latest_comments:[HMComment]?
    
    
}

struct HMComment: HandyJSON{
    var txt: String?
    var author: HMAuthor?
}

struct HMAuthor: HandyJSON{
    var name: String?
    var photo: String?
}


struct HMPhoto: HandyJSON {
    var ident: String?
    var original_width: CGFloat?
    var original_height: CGFloat?
    var ratio: CGFloat{
        return original_height! / original_width!
    }
}

