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
        collectionView.register(HMPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        (collectionView.collectionViewLayout as! HMPhotoCollectionViewLayout).model = model
        // 刷新标签
        collectionView.contentOffset = CGPoint(x: CGFloat(indexPath!.row) * YYScreenWidth, y: 0)
        scrollViewDidEndDecelerating(collectionView)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true

    }
    
}

extension HMPhotoController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model!.imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HMPhotoCollectionViewCell
        cell.imageView.kf.setImage(with: URL(string: (model?.imageUrls[indexPath.row])!))
        return cell
    }
    
}

extension HMPhotoController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickCancleButton()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 修改标签
        let cur = Int(collectionView.contentOffset.x / YYScreenWidth) + 1
        let total = model?.imageUrls.count
        pageLabel.text = "\(cur)/\(total!)"
        
        // 刷新imageView frame
        let index = scrollView.contentOffset.x / YYScreenWidth
        collectionView.cellForItem(at: IndexPath.init(item: Int(index), section: 0))?.layoutSubviews()
        
    }
}
