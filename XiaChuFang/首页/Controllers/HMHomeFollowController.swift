//
//  HMHomeFollowController.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/7/29.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MJRefresh

class HMHomeFollowController: UITableViewController {
    
    var models = [HMHomeFollowModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        observePhotoClick()
    }
}



extension HMHomeFollowController{
    // 初始化tableview的操作
    func setupTableView(){
        tableView.register(UINib.init(nibName: "HMHomeFollowCell", bundle: Bundle.main), forCellReuseIdentifier: "HMHomeFollowCell")
        tableView.separatorStyle = .none
        
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true;
        header.stateLabel?.isHidden = true
        header.ignoredScrollViewContentInsetTop = 0
        header.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
        tableView.mj_header = header
        header.beginRefreshing()
    }
    
    @objc func headerRefresh(){
        // 发送网络请求获取数据
        HMHomeProvider.request(.followList) {result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                self.models = JSONDeserializer<HMHomeFollowModel>.deserializeModelArrayFrom(json: json["content"]["feeds"].description)! as! [HMHomeFollowModel]
                self.tableView.reloadData()
                self.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    func observePhotoClick(){
        // 监听图片的点击，弹出照片控制器
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "clickPhoto"), object: nil, queue: OperationQueue.main){
            (notification) in
            let dict = notification.userInfo
            let indexPath: IndexPath = dict!["indexPath"] as! IndexPath
            let dish: HMDishModel = dict!["model"] as! HMDishModel
            let photoVc = HMPhotoController(indexPath: indexPath, model: dish)
            self.navigationController?.pushViewController(photoVc, animated: true)
        }
    }
}


// MARK: - tableview数据源方法
extension HMHomeFollowController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
}

// MARK:- 实现tableview代理方法
extension HMHomeFollowController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HMHomeFollowCell", for: indexPath) as! HMHomeFollowCell
        cell.model = models[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HMHomeFollowCell") as! HMHomeFollowCell
        cell.model = models[indexPath.row]
        cell.layoutIfNeeded()
        return cell.timeLabel.frame.maxY + 35
    }
    
}
