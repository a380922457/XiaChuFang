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
       
        setupNav()
        setupPagerView()
        
    }
    
    func setupPagerView(){
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
        let pageView = HMPageView(frame: CGRect(x: 0, y: 100, width: YYScreenWidth, height: YYScreenHeigth-100), style: style, titles: titles, childViewControllers: viewControllers, startIndex: 0)
        view.addSubview(pageView)
    }
    
    func setupNav(){
        // 设置导航条内容
        let titleView = HMNavSearchView.loadFromNib()
        titleView.frame = CGRect(x: 0, y: 0, width: (YYScreenWidth) - 140, height: 40)
        titleView.delegate = self
        navigationItem.titleView = titleView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "homepageCreateRecipeButton"), style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "notification"), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.barTintColor = .white

    }
}

extension HomeController: HMNavSearchViewDelegate{
    func clickSearchButton() {jump()}
    
    func clickSearchLabel() {jump()}
        
    func jump(){
        let vc = HMSearchFirstController.init(collectionViewLayout: HMSearchFirstLayout())
        navigationController?.pushViewController(vc, animated: false)
    }
}
