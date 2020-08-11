//
//  HMRecipeDetailController.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/8.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMRecipeDetailController: UITableViewController {
    var id: String?
    var heights = [CGFloat]()
    var model: HMRecipeDetailModel?
    var navBar: HMRecipeNavigationBar?
    var imageheight: CGFloat?
    
    convenience init(id: String){
        self.init()
        self.id = id
        model = HMRecipeDetailModel.getModel(id: id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        
        setupTableView()
        
        cacheHeights()
    }
    
    // 在viewDidLoad方法设置有时候会失效？
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
        UIApplication.shared.windows[0].addSubview(navBar!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = false
        navBar!.removeFromSuperview()
    }
    
    func setupTableView(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        scrollViewDidScroll(tableView)
        
        tableView.register(UINib.init(nibName: "HMRecipeHeaderCell", bundle: nil), forCellReuseIdentifier: "HMRecipeHeaderCell")
        tableView.register(UINib.init(nibName: "HMRecipeGradientsCell", bundle: nil), forCellReuseIdentifier: "HMRecipeGradientsCell")
    }
    
   
    func setupNav(){
        navBar = HMRecipeNavigationBar.loadFromNib()
        navBar!.frame = navigationController!.navigationBar.frame
        navBar!.delegate = self
    }
    
    func cacheHeights(){
        for i in 0..<2{
            if i == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeHeaderCell") as! HMRecipeHeaderCell
                cell.model = model
                cell.layoutIfNeeded()
                heights.append(cell.my_textLabel.frame.maxY)
            }else if i == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeGradientsCell") as! HMRecipeGradientsCell
                cell.model = model
                cell.layoutIfNeeded()
                heights.append(cell.gradientsTableView.frame.maxY)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return tableView.contentOffset.y + 40 > imageheight ?? 300 ? UIStatusBarStyle.darkContent : UIStatusBarStyle.lightContent
    }
    
        
}

extension HMRecipeDetailController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeHeaderCell", for: indexPath) as! HMRecipeHeaderCell
            cell.model = model
            imageheight = cell.imageHeight.constant
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeGradientsCell", for: indexPath) as! HMRecipeGradientsCell
            cell.model = model
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 设置tableView无法下拉
        if scrollView.contentOffset.y < 0{
            scrollView.contentOffset.y = 0
        }
        
        // 更新导航栏颜色和状态栏颜色height
        if scrollView.contentOffset.y + 40 >= imageheight ?? 300{
            navBar!.changeDarkColor()
        }else{
            navBar!.changeLightColor()
        }
        self.setNeedsStatusBarAppearanceUpdate()

    }
}

