//
//  HMSearchSecondController.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/7.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMSearchSecondController: UIViewController {
    var keyword: String?
    var searchLabel: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavUI()
        setupPagerView()
    }
    
    convenience init(keyword: String){
        self.init()
        self.keyword = keyword
    }
    
    func setupNavUI(){
        // 设置导航条内容
        let titleView = HMNavSearchView.loadFromNib()
        navigationItem.titleView = titleView
        titleView.frame = CGRect(x: 0, y: 0, width: (YYScreenWidth) - 140, height: 40)
        titleView.delegate = self
        titleView.searchLabel.text = keyword
        searchLabel = titleView.searchLabel
        titleView.clearButton?.isHidden = false
        titleView.scanButton?.isHidden = true

        let left = UIBarButtonItem.init(image: UIImage.init(named: "backStretchBackgroundNormal"), style: .plain, target: self, action: #selector(self.back))
        navigationItem.leftBarButtonItem = left
        
        let right = UIBarButtonItem.init(image: UIImage.init(named: "searchTypeSelect"), style: .plain, target: self, action: #selector(self.filter))
        right.tintColor = .red
        navigationItem.rightBarButtonItem = right
        
//        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.backgroundColor = .white
    }
    
    @objc func back(){
        navigationController?.popToViewController((navigationController?.children[0])!, animated: false)
    }
    
    @objc func filter(){
        
    }
    
    func setupPagerView(){
        let style = HMPageStyle()
        style.isTitleScrollEnable = true
        style.isShowBottomLine = true
        style.titleSelectedColor = .black
        style.titleColor = UIColor.gray
        style.bottomLineColor = .red
        style.bottomLineHeight = 3
        style.titleWidth = 120
        style.titleFontSize = 18
        style.titleMargin = 40
        

        let titles = ["智能排序", "评分最高", "做过最多", "视频菜谱"]
        let vc = HMSearchThirdController.init(keyword: keyword!)
        
        let viewControllers:[UIViewController] = [vc, vc, vc, vc]
        for vc in viewControllers{
            addChild(vc)
        }
        let pageView = HMPageView(frame: CGRect(x: 0, y: 100, width: YYScreenWidth, height: YYScreenHeigth-100), style: style, titles: titles, childViewControllers: viewControllers)
        view.addSubview(pageView)
    }
}


// MARK: 实现搜索框代理方法
extension HMSearchSecondController: HMNavSearchViewDelegate{
    func clickSearchButton() { navigationController?.popViewController(animated: false) }
    func clickSearchLabel() { navigationController?.popViewController(animated: false) }
}
