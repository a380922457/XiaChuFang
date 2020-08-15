//
//  HMHomeVideoController.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/7/29.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import IBAnimatable
import MJRefresh
import HandyJSON
import SwiftyJSON
import Kingfisher
import KingfisherWebP

class HMHomeVideoController: UIViewController {

    lazy var models = [HMRecModel]()

    lazy var bannerModels = [HMVideoBannerModel]()

    
    @IBOutlet weak var bannerView: UICollectionView!
    
    @IBOutlet weak var breakfastButton: AnimatableButton!
    
    @IBOutlet weak var lunchButton: AnimatableButton!
    
    @IBOutlet weak var dinnerButton: AnimatableButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        (view as! UIScrollView).delegate = self
        
    }
    
    func setupCollectionView(){
        bannerView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        bannerView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        let bannerLayout = bannerView.collectionViewLayout as! UICollectionViewFlowLayout
        bannerLayout.itemSize = CGSize(width: 180, height: 130)
        bannerLayout.minimumInteritemSpacing = 10
        
        collectionView.register(UINib.init(nibName: "HMHomeRecCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HMHomeVideoCollectionViewCell")
    
        // 添加下拉刷新控件，进来就刷新数据
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel?.isHidden = true;
        header.stateLabel?.isHidden = true
        header.ignoredScrollViewContentInsetTop = 0
        header.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
        (view as! UIScrollView).mj_header = header
        header.beginRefreshing()
//        headerRefresh()
        
        // 添加底部刷新控件
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
        collectionView.mj_footer = footer
        
    }
}


// 实现上拉下拉刷新网络请求
extension HMHomeVideoController{
    // 下拉刷新
    @objc func headerRefresh(){
        // 更新瀑布流video
        HMHomeProvider.request(.video) {
            result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let tmp = JSONDeserializer<HMVideoOuter>.deserializeModelArrayFrom(json: json["content"]["recommendations"].description) as! [HMVideoOuter]
                var models = [HMRecModel]()
                for line: HMVideoOuter in tmp{
                    guard let _ = line.recommend_content?.title_1st else {continue}
                    models.append(line.recommend_content!)
                }
                self.models = models
                // 赋值，刷新
                (self.collectionView.collectionViewLayout as! HMHomeRecColleciontViewLayout).models = self.models
                
                self.collectionView.reloadData()
                (self.view as! UIScrollView).mj_header?.endRefreshing()
            }
        }
        
        // 更新上方banner信息
        HMHomeProvider.request(.kitchen_activities) {
            result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let tmp = JSONDeserializer<HMVideoBannerOuter>.deserializeModelArrayFrom(json: json["content"]["explore_tabs"][0]["portals"].description) as! [HMVideoBannerOuter]
                var models = [HMVideoBannerModel]()
                for line: HMVideoBannerOuter in tmp{
                    guard let _ = line.object?.title_1st else {continue}
                    models.append(line.object!)
                }
                self.bannerModels = models
                self.bannerView.reloadData()
            }
        }
        
    }
    
    // 上拉加载更多
    @objc func footerRefresh(){
        HMHomeProvider.request(.video) {
            result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let tmp = JSONDeserializer<HMVideoOuter>.deserializeModelArrayFrom(json: json["content"]["recommendations"].description) as! [HMVideoOuter]
                for line: HMVideoOuter in tmp{
                    guard let _ = line.recommend_content?.title_1st else {continue}
                    self.models.append(line.recommend_content!)
                }
                // 赋值，刷新
                (self.collectionView.collectionViewLayout as! HMHomeRecColleciontViewLayout).models = self.models
                
                self.collectionView.reloadData()
            }
        }
        collectionView.mj_footer?.endRefreshing()
    }
}


extension HMHomeVideoController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            print(bannerModels.count)
            return bannerModels.count
        }else{
            return models.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            let cell = bannerView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            for sub in cell.contentView.subviews {sub.removeFromSuperview()}
            let imageView = UIImageView.init()
            imageView.layer.cornerRadius = 8
            imageView.layer.masksToBounds = true
            imageView.frame = cell.contentView.frame
            imageView.kf.setImage(with: URL(string: bannerModels[indexPath.row].image?.image_url ?? ""))
            cell.contentView.addSubview(imageView)
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HMHomeVideoCollectionViewCell", for: indexPath) as! HMHomeRecCollectionViewCell
            cell.model = models[indexPath.row]
            return cell
        }
    }
}

extension HMHomeVideoController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let upView = (self.view as! UIScrollView)

        // 设置scrollView无法左右拉
        scrollView.contentOffset.x = 0
        
        // scrollView最多能滚200，就到下面的view表演了
        if scrollView.contentOffset.y > 200 && !scrollView.isKind(of: UICollectionView.self){
            scrollView.contentOffset.y = 200
        }
        
        
        // 下面的view要等到上面的view滚到底，才能继续往下
        if scrollView.isKind(of: UICollectionView.self) && scrollView.contentOffset.y > 0 && upView.contentOffset.y < 200{
            upView.contentOffset.y += scrollView.contentOffset.y
            scrollView.contentOffset.y = 0
        }
        
        // 下面的View不能往上拉，此时，告诉上方的view往上拉
        if scrollView.contentOffset.y < 0 && scrollView.isKind(of: UICollectionView.self)
            && upView.contentOffset.y <= 200{
            upView.contentOffset.y += scrollView.contentOffset.y
            scrollView.contentOffset.y = 0
        }
    }
}
