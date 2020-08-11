//
//  HMSearchRecipeModel.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/5.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import Foundation
import Ji


struct HMSearchRecipeModel {
    var title: String?
    var rate: String?
    var number: String?
    var imageUrl: String?
    var authorImageUrl: String?
    var authorName: String?
    var id: String?
    
    static func getModels(keyword: String, page: Int = 1) -> [Self]{
        let url = "https://www.xiachufang.com/search/?keyword=\(keyword)&cat=1001&page=\(page)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        
        let jiDoc = Ji(htmlURL: URL(string: url)!)!
        let titles = jiDoc.xPath("//p[@class='name']")!
        let stats = jiDoc.xPath("//p[@class='stats']")!
        let authors = jiDoc.xPath("//p[@class='author']")!
        let imageUrls = jiDoc.xPath("//div[@class='cover pure-u']")
        var models = [HMSearchRecipeModel]()
        
        
        for i in 0..<titles.count{
            var model = HMSearchRecipeModel()
                        
            model.title = titles[i].xPath("a").first!.content!.trimmingCharacters(in: ["\n", " "])
//            print(titles[i].xPath("a").first!.attributes["href"])
            
            let id = titles[i].xPath("a").first!.attributes["href"]!.split(separator: "/")[1]
            
            model.id = String(id)
            
            let span = stats[i].xPath("span")
            if span.count == 2{
                model.number = span[1].content
                model.rate = span[0].content
            }else if span.count == 1{
                model.number = span[0].content
            }


            model.authorName = authors[i].xPath("a").first?.content
            model.imageUrl = imageUrls![i].xPath("img")[0].attributes["data-src"]
            
            models.append(model)
        }
        return models
    }
    
}

