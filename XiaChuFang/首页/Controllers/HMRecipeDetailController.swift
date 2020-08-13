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
    var tabBar: HMRecipeTabBar?
    var imageheight: CGFloat?
    
    convenience init(id: String){
        self.init()
        self.id = id
        model = HMRecipeDetailModel.getModel(id: id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBars()
        
        setupTableView()
        
        cacheHeights()
    }
    
    // 在viewDidLoad方法设置有时候会失效？
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
        UIApplication.shared.windows[0].addSubview(navBar!)
        UIApplication.shared.windows[0].addSubview(tabBar!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = false
        navBar!.removeFromSuperview()
        tabBar!.removeFromSuperview()
    }
    
    func setupTableView(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        scrollViewDidScroll(tableView)
        
        tableView.register(UINib.init(nibName: "HMRecipeHeaderCell", bundle: nil), forCellReuseIdentifier: "HMRecipeHeaderCell")
        tableView.register(UINib.init(nibName: "HMRecipeGradientsCell", bundle: nil), forCellReuseIdentifier: "HMRecipeGradientsCell")
        tableView.register(UINib.init(nibName: "HMRecipeStepCell", bundle: nil), forCellReuseIdentifier: "HMRecipeStepCell")
        tableView.register(UINib.init(nibName: "HMRecipeTipCell", bundle: nil), forCellReuseIdentifier: "HMRecipeTipCell")
        tableView.register(UINib.init(nibName: "HMRecipeCommentCell", bundle: nil), forCellReuseIdentifier: "HMRecipeCommentCell")
        tableView.register(UINib.init(nibName: "HMRecipePeopleCookCell", bundle: nil), forCellReuseIdentifier: "HMRecipePeopleCookCell")
        
    }
    
   
    func setupBars(){
        navBar = HMRecipeNavigationBar.loadFromNib()
        navBar!.frame = navigationController!.navigationBar.frame
        navBar!.delegate = self
        
        tabBar = HMRecipeTabBar.loadFromNib()
        tabBar!.frame = tabBarController!.tabBar.frame
        tabBar!.frame.origin.y += 20
        tabBar!.frame.size.height -= 20
        
    }
    
    func cacheHeights(){
        let stepCount = (model?.steps.count ?? 0)
        for i in 0..<(5 + stepCount){
            if i == 0{
                // 计算headerView的高度
                let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeHeaderCell") as! HMRecipeHeaderCell
                cell.model = model
                cell.layoutIfNeeded()
                heights.append(cell.my_textLabel.frame.maxY)
            }else if i == 1{
                // 计算原材料cell的高度
                let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeGradientsCell") as! HMRecipeGradientsCell
                cell.model = model
                cell.layoutIfNeeded()
                heights.append(cell.gradientsTableView.frame.maxY)
            }else if i < stepCount + 2{
                // 计算步骤cell的高度
                let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeStepCell") as! HMRecipeStepCell
                cell.curIndex = i - 1
                cell.model = model
                cell.layoutIfNeeded()
                heights.append(cell.separationLine.frame.maxY)
            }else if i == stepCount + 2{
                // 计算小贴士cell的高度
                if model?.smallTip == nil{
                    // 小贴士可能不存在
                    heights.append(0)
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeTipCell") as! HMRecipeTipCell
                    cell.model = model
                    cell.layoutIfNeeded()
                    heights.append(cell.my_contentView.frame.maxY)
                }
            }else if i == stepCount + 3{
                // 计算评论cell的高度
                let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeCommentCell") as! HMRecipeCommentCell
                cell.model = model
                if model?.comments.count == 0{
                    heights.append(0)
                }else{
                    cell.layoutIfNeeded()
                    heights.append(cell.commentButton.frame.maxY)
                }

            }else if i == stepCount + 4{
                // 计算大家作品cell的高度
                let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipePeopleCookCell") as! HMRecipePeopleCookCell
                cell.model = model
                if model?.peoples.count == 0{
                    heights.append(0)
                }else{
                    cell.layoutIfNeeded()
                    heights.append(cell.collectionView.frame.maxY)
                }
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
        return 5 + (model?.steps.count ?? 0)
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
        }else if indexPath.row < 2 + (model?.steps.count ?? 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeStepCell") as! HMRecipeStepCell
            cell.curIndex = indexPath.row - 1
            cell.model = model
            return cell
        }else if indexPath.row == 2 + (model?.steps.count ?? 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeTipCell") as! HMRecipeTipCell
            cell.model = model
            return cell
        }else if indexPath.row == 3 + (model?.steps.count ?? 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeCommentCell") as! HMRecipeCommentCell
            cell.model = model
            return cell
        }else if indexPath.row == 4 + (model?.steps.count ?? 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipePeopleCookCell") as! HMRecipePeopleCookCell
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

        
        // 修改tableview的contentSize，因为tabbar会挡住
        tableView.contentSize.height = heights.reduce(0, +) + 55
        
    }
}

