//
//  const.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/26.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import Foundation
import UIKit

let YYScreenWidth = UIScreen.main.bounds.size.width
let YYScreenHeigth = UIScreen.main.bounds.size.height
let DominantColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let FooterViewColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

// iphone X
let isIphoneX = YYScreenHeigth == 812 ? true : false
// navigationBarHeight
let navigationBarHeight : CGFloat = isIphoneX ? 88 : 64
// tabBarHeight
let tabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49
