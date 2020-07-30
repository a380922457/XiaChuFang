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
        tableView.rowHeight = 500
        HMHomeProvider.request(.followList) {result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                self.models = JSONDeserializer<HMHomeFollowModel>.deserializeModelArrayFrom(json: json["content"]["feeds"].description)! as! [HMHomeFollowModel]
                self.tableView.reloadData()
                
            }
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
