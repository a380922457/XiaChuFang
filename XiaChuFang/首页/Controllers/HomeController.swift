//
//  HomeController.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/26.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 隐藏导航条
        navigationController?.navigationBar.isHidden = true
        
        // 自定义导航条
        let titleView = HMNavSearchView.loadFromNib()
        titleView.frame = CGRect(x: 0, y: 44, width: YYScreenWidth, height: 40)
        view.addSubview(titleView)
        
       
        // 加载下方pageview
        let style = HMPageStyle()
        style.isTitleScrollEnable = false
        style.isShowBottomLine = true
        style.titleSelectedColor = .black
        style.titleColor = UIColor.gray
        style.bottomLineColor = .red
        style.bottomLineHeight = 3
        style.titleWidth = 80
        style.titleFontSize = 18
            
        let titles = ["关注", "推荐", "视频"]
        let viewControllers:[UIViewController] = [HMHomeFollowController(), HMHomeRecController(), HMHomeVideoController()]
        for vc in viewControllers{
            addChild(vc)
        }
        let pageView = HMPageView(frame: CGRect(x: 0, y: 100, width: YYScreenWidth, height: YYScreenHeigth-100), style: style, titles: titles, childViewControllers: viewControllers, startIndex: 1)
        view.addSubview(pageView)
        
    }
}
