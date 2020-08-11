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

class HMHomeFollowController: UITableViewController {
    
    let cellID = "cellID"
    var models = [HMHomeFollowModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "HMHomeFollowCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        
        // 发送网络请求获取数据
        HMHomeProvider.request(.followList) {result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                self.models = JSONDeserializer<HMHomeFollowModel>.deserializeModelArrayFrom(json: json["content"]["feeds"].description)! as! [HMHomeFollowModel]
                self.tableView.reloadData()
            }
        }
        
        // 监听图片的点击
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


// MARK:- 实现tableview代理方法
extension HMHomeFollowController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HMHomeFollowCell
        cell.model = models[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! HMHomeFollowCell
        cell.model = models[indexPath.row]
        cell.layoutIfNeeded()
        return cell.timeLabel.frame.maxY + 35
    }
    
}

// MARK: - tableview数据源方法
extension HMHomeFollowController{

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
}
