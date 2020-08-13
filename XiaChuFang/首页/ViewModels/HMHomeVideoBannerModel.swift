//
//  HMHomeVideoModel.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/13.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import Foundation
import HandyJSON


struct HMVideoBannerOuter: HandyJSON {
    var object: HMVideoBannerModel?
}

struct HMVideoBannerModel: HandyJSON {
    var title_1st: String?
    var image: HMPhoto?

}
