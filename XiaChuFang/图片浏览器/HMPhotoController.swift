//
//  HMPhotoController.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/1.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMPhotoController: UIViewController {

    var indexPath: IndexPath?
    var model: HMDishModel?
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func clickCancleButton() {
        navigationController?.popViewController(animated: true)
        
        // 显示tabbar,navbar
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    convenience init(indexPath: IndexPath, model: HMDishModel){
        self.init()
        self.indexPath = indexPath
        self.model = model
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏tabbar,navbar
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        
        // 设置collectionView
        collectionView.register(HMPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: YYScreenWidth, height: YYScreenHeigth)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        
        // 滚到对应位置
        collectionView.contentOffset = CGPoint(x: CGFloat(indexPath!.row) * YYScreenWidth, y: 0)
        
        // 监听单击图片
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickCancleButton), name: NSNotification.Name(rawValue: "tapImage"), object: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
}

extension HMPhotoController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model!.imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HMPhotoCollectionViewCell
        cell.imageUrl = model?.imageUrls[indexPath.row]
        cell.imageRatio = model?.imageRatios[indexPath.row]
        
        return cell
    }
}

extension HMPhotoController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 还原图片
        (cell as! HMPhotoCollectionViewCell).scrollView.zoomScale = 1
        (cell as! HMPhotoCollectionViewCell).scale = 1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 更新索引标签
        let total = model?.imageUrls.count
        pageLabel.text = "\(indexPath.row + 1)/\(total!)"
    }
}
