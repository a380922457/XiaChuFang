//
//  HMHomeRecController.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/28.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MJRefresh

class HMHomeRecController: UIViewController {
    let ID = "HMHomeRecCollectionViewCell"
    lazy var models = [HMRecModel]()
    
    // 瀑布流collectionView
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: YYScreenWidth, height: YYScreenHeigth - 44), collectionViewLayout: HMHomeRecColleciontViewLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(UINib.init(nibName: "HMHomeRecCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: ID)
        return collectionView
    }()
    
    // 为你推荐，菜谱分类 headerView
    lazy var headerView: UIView = {
        let height: CGFloat = 60
        collectionView.contentInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        let headerView = UIView()
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: 100, height: 60))
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "为你推荐"
        headerView.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: YYScreenWidth - 15 - 80, y: 5, width: 80, height: 50))
        button.setTitle("菜谱分类", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(self.clickRecipeCatogory), for: .touchUpInside)
        headerView.addSubview(button)

        headerView.frame = CGRect(x: 0, y: -height, width: YYScreenWidth, height: height)
        return headerView
    }()
    
    // 下拉刷新控件
    lazy var headerRefresher: MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true;
        header.stateLabel?.isHidden = true
        header.ignoredScrollViewContentInsetTop = 60
        header.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
        collectionView.mj_header = header
        return header
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.addSubview(headerView)
        
        // 进来就刷新数据
        headerRefresher.beginRefreshing()
        
        // 添加底部刷新控件
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
        collectionView.mj_footer = footer

    }
    
    
}


// 点击菜谱分类按钮弹出控制器
extension HMHomeRecController{
    @objc func clickRecipeCatogory(){
     navigationController?.pushViewController(HMRecipeCatogoryController(), animated: false)
    }
}

// 实现上拉下拉刷新网络请求
extension HMHomeRecController{
    // 下拉刷新
    @objc func headerRefresh(){
        HMHomeProvider.request(.rec) {
            result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let tmp = JSONDeserializer<HMOuterModel>.deserializeModelArrayFrom(json: json["content"]["recommendations"].description) as! [HMOuterModel]
                var models = [HMRecModel]()
                for line: HMOuterModel in tmp{
                    guard let _ = line.object?.title_1st else {continue}
                    models.append(line.object!)
                }
                self.models = models
                // 赋值，刷新
                (self.collectionView.collectionViewLayout as! HMHomeRecColleciontViewLayout).models = self.models
                self.collectionView.reloadData()
                self.collectionView.mj_header?.endRefreshing()
            }
        }
        
    }
    
    // 上拉加载更多
    @objc func footerRefresh(){
        HMHomeProvider.request(.rec) {
            result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let tmp = JSONDeserializer<HMOuterModel>.deserializeModelArrayFrom(json: json["content"]["recommendations"].description) as! [HMOuterModel]
                for line: HMOuterModel in tmp{
                    guard let _ = line.object?.title_1st else {continue}
                    self.models.append(line.object!)
                }
                // 赋值，刷新
                (self.collectionView.collectionViewLayout as! HMHomeRecColleciontViewLayout).models = self.models
                self.collectionView.reloadData()
            }
        }
        collectionView.mj_footer?.endRefreshing()
    }
}


extension HMHomeRecController: UICollectionViewDelegate{
    // 点击cell 弹出菜谱详情
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = HMRecipeDetailController.init(id: models[indexPath.row].id!)
        navigationController?.pushViewController(vc, animated: false)
    }
}

// collectionView数据源方法
extension HMHomeRecController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! HMHomeRecCollectionViewCell
        cell.model = models[indexPath.row]
        return cell
    }
    
}
