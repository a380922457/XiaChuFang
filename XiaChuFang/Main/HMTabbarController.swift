//
//  TabbarController.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/26.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(HMTabBar(), forKey: "tabBar")
    
        setupUI()
    }
    
    func setupUI(){
        let titles = ["下厨房", "市集", "课堂", "收藏", "我"]
        let imgs = ["A", "B", "C", "D", "E"]
        
        for (i, title) in titles.enumerated() {
            addChildViewController(childVc: HomeController(), title: title, img: "tab" + imgs[i] + "Deselected", selImg: "tab" + imgs[i] + "Selected")
            
        }
     }
     
     func addChildViewController(childVc: UIViewController, title: String, img: String, selImg: String){
        childVc.tabBarItem.title = title
        childVc.tabBarItem.image = UIImage(named: img)
        childVc.tabBarItem.selectedImage = UIImage(named: selImg)
        addChild(HMNavigationController(rootViewController: childVc))
     }
    
}
