//
//  HMHomeFollowCollectionView.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/2.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

open class HMHomeFollowCollectionView: UICollectionView {
    @IBOutlet weak var collectionViewHeightLayout: NSLayoutConstraint!
    var model: HMDishModel?{
        didSet{
            (collectionViewLayout as! HMCollectionViewFlowLayout).model = model
        }
    }
    override open func awakeFromNib(){
        super.awakeFromNib()
        delegate = self
        dataSource = self
        register(HMHomeFollowCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // 动态修改collectionView的高度
        let layout = collectionViewLayout as! HMCollectionViewFlowLayout
        let itemHeight: CGFloat = layout.itemSize.height
        collectionViewHeightLayout.constant = (model!.extra_images?.count == 0 ? itemHeight : CGFloat((model!.extra_images?.count)! / 3 + 1) * itemHeight) + 10
        
    }
}

extension HMHomeFollowCollectionView: UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model!.imageUrls.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HMHomeFollowCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HMHomeFollowCollectionViewCell
        
        cell.imageView.frame.size = (collectionView.collectionViewLayout as! HMCollectionViewFlowLayout).itemSize
        cell.imageView.kf.setImage(with: URL(string: model!.imageUrls[indexPath.row]!))
        
        return cell
    }
    
    
}

extension HMHomeFollowCollectionView: UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "clickPhoto"), object: nil, userInfo: ["indexPath": indexPath, "model": model!])
        
    }
}
