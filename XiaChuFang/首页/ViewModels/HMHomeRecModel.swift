//
//  HMHomeRecModel.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/4.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import Foundation
import HandyJSON

struct HMVideoOuter: HandyJSON {
    var recommend_content: HMRecModel?
}

struct HMOuterModel: HandyJSON {
    var object: HMRecModel?
}

struct HMExtra: HandyJSON {
    var is_video_recipe: Bool?
    var n_collects: String?
    var extra_icon_value: String?
}


struct HMRecModel: HandyJSON {
    var title_1st: String?
    var title_3rd: String?
    var image: HMPhoto?
    var author: Dictionary<String, Dictionary<String, String>>?
    var extra: HMExtra?
    
    var authorName: String?{
        return title_3rd
    }
    
    var authorImage: String{
        return "http://i2.chuimg.com/" + (author?["image"]?["ident"] ?? "")
    }
}


