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
    case search // 查找
    case changeOtherCategory(categoryId:Int) // 更换其他
}


extension HMHomeAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .followList:
            return URL(string: "https://api.xiachufang.com")!
        default:
            return URL(string: "https://api.xiachufang.com")!
        }
    }

    var path: String {
        switch self {
        case .followList: return "/v2/account/feeds_v6.json"
        case .rec: return "/v2/homepage1810/paged_waterfall_recommendations.json"
        case .changeOtherCategory(let categoryId): return "1"
//        case .search: return "/v2/categories/explorations_v2.json"
        case .search: return "/v2/search/universal_search_v2.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .post
        default:
            return .get
        }
    }
    var task: Task {
        var parameters:[String:Any] = [
            "_ts":"1596096925.035904",
            "api_key":"07397197043fafe11ce5c65c10febf84",
            "api_sign":"a2669eb6be6a5be31291a33b3485f440",
            "location_code":"156110000000000",
            "nonce":"38BDB913-719E-45CE-B82D-7F9BB7649A64",
            "origin":"iphone",
            "size":20,
            "timezone":"Asia/Shanghai",
            "version":"237.5.0",
            "webp":1,
        "sk":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOjgxMDIzMTc0LCJ1aWQiOjEwNDEyNjcyMywiaWF0IjoxNTk1OTkyOTAzLjAsIm8iOjJ9.ezRZ2q1iNjWtLnQY2Wlwh1-JooIshNAhiVs00jVca_4"]
        switch self {
        case .followList:
            break
        case .rec:
            parameters["_ts"] = "1596503887.838563"
            parameters["api_sign"] = "2e07632f87046bcdf994dc389717beb6"
            parameters["nonce"] = "471CC518-F5E9-477C-B805-417238BC2EAE"
            parameters["cursor"] = ""
        case .search:
            parameters["search_type"] = 1091
            parameters["q"] = "辣椒炒肉"
//            parameters["origin"] = "iphone"
            parameters["_ts"] = "1596600745.552623"
            parameters["api_sign"] = "b3af7f4c746868e3878f8f13c3645d17"
            parameters["nonce"] = "B7918B8A-1025-498A-A764-7E7C45CDF4BD"
            parameters["cursor"] = ""
            parameters["ifa"] = "AC84AD64-3941-4035-BADD-988946F713EE"

            
        case .changeOtherCategory(let categoryId):
            parameters = [
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
            parameters["categoryId"] = categoryId
        }
        

        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

