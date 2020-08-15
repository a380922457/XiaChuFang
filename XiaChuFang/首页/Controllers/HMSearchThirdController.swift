//
//  HMSearchSecondSubController.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/7.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import MJRefresh

enum HMSortedType {
    case rate
    case done
    case smart
}

class HMSearchThirdController: UITableViewController {
    var models: [HMSearchRecipeModel]?
    var keyword: String?
    var sortedType: HMSortedType?
    var page = 2
    
    let cellID = "HMSearchTableViewCell"
    convenience init(keyword: String, sortedType: HMSortedType = .smart){
        self.init()
        self.keyword = keyword
        self.sortedType = sortedType
    }
    
    // 下拉刷新控件
    lazy var headerRefresher: MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true;
        header.stateLabel?.isHidden = true
        header.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
        tableView.mj_header = header
        return header
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: cellID, bundle: Bundle.main), forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        tableView.rowHeight = 140
        
        // 进来就刷新数据
        headerRefresher.beginRefreshing()
        
        // 添加footer
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
        footer.isRefreshingTitleHidden = true
        footer.stateLabel?.text = ""
        tableView.mj_footer = footer
        
    }
    
    @objc func headerRefresh(){
        models = HMSearchRecipeModel.getModels(keyword: keyword!)
        models?.sort(by: { (model1, model2) -> Bool in
            switch sortedType{
            case .rate: return model1.rate ?? 0 > model2.rate ?? 0
            case .done: return model1.number ?? 0 > model2.number ?? 0
            default: return false
            }
        })
        page = 1
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
    }
    
    @objc func footerRefresh(){
        page += 1
        models! += HMSearchRecipeModel.getModels(keyword: keyword!, page: page)
        models?.sort(by: { (model1, model2) -> Bool in
            switch sortedType{
            case .rate: return model1.rate ?? 0 > model2.rate ?? 0
            case .done: return model1.number ?? 0 > model2.number ?? 0
            default: return false
            }
        })
        
        tableView.reloadData()
        tableView.mj_footer?.endRefreshing()
    }
    
}


// MARK: tableView数据源和代理方法
extension HMSearchThirdController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HMSearchTableViewCell
        cell.model = models![indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HMRecipeDetailController(id: models![indexPath.row].id!)
        navigationController?.pushViewController(vc, animated: false)
    }
    
}
