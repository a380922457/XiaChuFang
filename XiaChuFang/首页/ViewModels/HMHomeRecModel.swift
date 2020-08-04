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
    var image: HMPhoto?
    var author: HMAuthor?
    var extra: Dictionary<String, String>?
}


