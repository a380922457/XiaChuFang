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
    
    /// 第一张图片的url
    var photo: String?
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
    
    /// 额外图片
    var extra_pics: [HMImage]?
    var author: HMAuthor?
    
    
}

struct HMAuthor: HandyJSON{
    var name: String?
    var photo: String?
}

struct HMImage: HandyJSON {
    var url: String?
}
