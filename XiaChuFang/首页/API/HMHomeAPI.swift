//
//  HMHomeRecAPI.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/28.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

/// 首页推荐主接口
let HMHomeProvider = MoyaProvider<HMHomeAPI>()

enum HMHomeAPI {
    case followList //关注列表
    case rec //推荐列表
    case video // 视频界面
    case kitchen_activities // 查找
//    case changeOtherCategory(categoryId:Int) // 更换其他
}


extension HMHomeAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://api.xiachufang.com")!
        }
    }

    var path: String {
        switch self {
        case .followList: return "/v2/account/feeds_v6.json"
        case .rec: return "/v2/homepage1810/paged_waterfall_recommendations.json"
        case .video: return "/v2/city/get_same_city_recommendations.json"
        case .kitchen_activities: return "/v2/homepage1810/dish/init_page.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    var task: Task {
        var parameters:[String:Any] = [
            "api_key":"07397197043fafe11ce5c65c10febf84",
            "location_code":"156110000000000",
            "origin":"iphone",
            "timezone":"Asia/Shanghai",
            "version":"237.5.0",
            "webp":1,
            ]
        switch self {
        case .followList:
            parameters["_ts"] = "1597320495.553144"
            parameters["api_sign"] = "2de47dd8e186576c93d9d2a00b56f702"
            parameters["nonce"] = "15A5CE2B-B0E5-4C55-82F9-E9E444533D48"
            parameters["size"] = 20
            parameters["sk"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOjgyNDQxODM0LCJ1aWQiOjEwNDEyNjcyMywiaWF0IjoxNTk3MzA0MjEzLjAsIm8iOjJ9._O3E5bXq0oB8KpDF6DBz4aaAAV7rE3yrRnR7pd9ybLw"
        case .rec:
            parameters["_ts"] = "1597320802.125984"
            parameters["api_sign"] = "96e6642662df8bccc75d419230c81841"
            parameters["nonce"] = "245017E8-D6F9-4338-9B8C-55E23D0BE100"
            parameters["cursor"] = ""
            parameters["size"] = 20
            parameters["sk"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOjgyNDQxODM0LCJ1aWQiOjEwNDEyNjcyMywiaWF0IjoxNTk3MzA0MjEzLjAsIm8iOjJ9._O3E5bXq0oB8KpDF6DBz4aaAAV7rE3yrRnR7pd9ybLw"
        case .video:
            parameters["_ts"] = "1597304226.088708"
            parameters["api_sign"] = "da1879e2a0f641868406f3788a612bed"
            parameters["nonce"] = "20A8E5BC-4A97-45B9-84D6-C264E1759BCD"
            parameters["cursor"] = ""
            parameters["sk"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOjgyNDQxODM0LCJ1aWQiOjEwNDEyNjcyMywiaWF0IjoxNTk3MzA0MjEzLjAsIm8iOjJ9._O3E5bXq0oB8KpDF6DBz4aaAAV7rE3yrRnR7pd9ybLw"
            parameters["size"] = 20
        case .kitchen_activities:
            parameters["_ts"] = "1597304226.084011"
            parameters["api_sign"] = "bc713907b03980f5098b6e554bc3e36e"
            parameters["nonce"] = "B2F69EE1-B470-4DBE-820A-18A5F9AF51AF"
            parameters["sk"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOjgyNDQxODM0LCJ1aWQiOjEwNDEyNjcyMywiaWF0IjoxNTk3MzA0MjEzLjAsIm8iOjJ9._O3E5bXq0oB8KpDF6DBz4aaAAV7rE3yrRnR7pd9ybLw"
            
//        case .changeOtherCategory(let categoryId):
//            parameters = [
//                "xt": Int32(Date().timeIntervalSince1970),
//                "deviceId": UIDevice.current.identifierForVendor!.uuidString
//            ]
//            parameters["categoryId"] = categoryId
//        }
        }

        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

