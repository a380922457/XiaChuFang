//
//  HMHomeRecModel.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/4.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import Foundation
import HandyJSON

struct HMOuterModel: HandyJSON {
    var object: HMRecModel?
}

struct HMRecModel: HandyJSON {
    var title_1st: String?
    var title_3rd: String?
    var image: HMPhoto?
    var author: Dictionary<String, Dictionary<String, String>>?
    var extra: Dictionary<String, String>?
    
    var authorName: String?{
        return title_3rd
    }
    
    var authorImage: String{
        return "http://i2.chuimg.com/" + (author?["image"]?["ident"] ?? "")
    }
}


