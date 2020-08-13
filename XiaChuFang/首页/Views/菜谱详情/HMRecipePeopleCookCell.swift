//
//  HMRecipePeopleCookCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/12.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMRecipePeopleCookCell: UITableViewCell {

    var model: HMRecipeDetailModel?{
        didSet{
            my_titleLabel.text = "大家做的这道菜（\(model!.doneNumber ?? "0")）"
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var my_titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "HMRecipePeopleMakeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HMRecipePeopleMakeCollectionCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewHeight.constant = 335
        layout.itemSize = CGSize(width: 180, height: 335)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
    }
}


extension HMRecipePeopleCookCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.peoples.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HMRecipePeopleMakeCollectionCell", for: indexPath) as! HMRecipePeopleMakeCollectionCell
        cell.model = model!.peoples[indexPath.row]
        cell.backgroundColor = .yellow
        return cell
        
    }
    
    
}
