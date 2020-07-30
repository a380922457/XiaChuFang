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
    case changeOtherCategory(categoryId:Int)// 更换其他
}

extension HMHomeAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .followList:
            return URL(string: "https://api.xiachufang.com")!
        default:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }

    var path: String {
        switch self {
        case .followList: return "/v2/account/feeds_v6.json"
        case .changeOtherCategory(let categoryId): return "1"
            
        }
        
    }

    var method: Moya.Method { return .get }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .followList:
            parmeters = [
                "_ts":"1596096925.035904",
//                "_ts": "\(Date().timeIntervalSince1970)",
                "api_key":"07397197043fafe11ce5c65c10febf84",
                "api_sign":"a2669eb6be6a5be31291a33b3485f440",
                "location_code":"156110000000000",
                "nonce":"38BDB913-719E-45CE-B82D-7F9BB7649A64",
                "origin":"iphone",
                "size":20,
                "sk":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOjgxMDIzMTc0LCJ1aWQiOjEwNDEyNjcyMywiaWF0IjoxNTk1OTkyOTAzLjAsIm8iOjJ9.ezRZ2q1iNjWtLnQY2Wlwh1-JooIshNAhiVs00jVca_4",
                "timezone":"Asia/Shanghai",
                "version":"237.5.0",
                "webp":1]
        
        case .changeOtherCategory(let categoryId):
            parmeters = [
                "appid":0,
                "excludedAlbumIds":"7024810%2C8424399%2C8125936",
                "excludedAdAlbumIds":"13616258",
                "excludedOffset":3,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":3,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
            parmeters["categoryId"] = categoryId
        }
        

        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

