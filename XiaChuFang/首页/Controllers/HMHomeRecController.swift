//
//  HMHomeRecController.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/28.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HMHomeRecController: UIViewController {

    var models = [HMRecModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 发送网络请求获取数据
        HMHomeProvider.request(.rec) {result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let tmp = JSONDeserializer<HMOuterModel>.deserializeModelArrayFrom(json: json["content"]["recommendations"].description) as! [HMOuterModel]
                for line: HMOuterModel in tmp{
                    self.models.append(line.object!)
                }
            }
        }
    }
}

