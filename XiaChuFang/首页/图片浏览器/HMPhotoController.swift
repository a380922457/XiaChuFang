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
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    convenience init(indexPath: IndexPath, model: HMDishModel){
        self.init()
        self.indexPath = indexPath
        self.model = model
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(HMHomeFollowCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        (collectionView.collectionViewLayout as! HMPhotoCollectionViewLayout).model = model
        collectionView.contentOffset = CGPoint(x: CGFloat(indexPath!.row) * YYScreenWidth, y: 0)
        scrollViewDidEndDecelerating(collectionView)
    }
}

extension HMPhotoController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model!.imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HMHomeFollowCollectionViewCell
        
        cell.imageView.frame.size = cell.frame.size        
        // 设置图片
        cell.imageView.kf.setImage(with: URL(string: (model?.imageUrls[indexPath.row])!))
        
        return cell
    }
}

extension HMPhotoController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickCancleButton()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let cur = Int(collectionView.contentOffset.x / YYScreenWidth) + 1
        let total = model?.imageUrls.count
        pageLabel.text = "\(cur)/\(total!)"
    }
}
