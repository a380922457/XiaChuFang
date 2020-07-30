//
//  HMHomeFollowCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/7/29.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import Kingfisher

class HMHomeFollowCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topicButton: UIButton!
    
    @IBOutlet weak var likeNumber: UILabel!
    @IBOutlet weak var commentNumber: UILabel!
    @IBOutlet weak var collecNumber: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var aritcleYLayout: NSLayoutConstraint!
    @IBOutlet weak var aritcleHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var topicButtonLayout: NSLayoutConstraint!
    
    var dish: HMDishModel!
    
    var model: HMHomeFollowModel?{
        didSet{
            dish = model!.dish!
            
            /// 设置作者头像
            iconView.kf.setImage(with: URL(string: dish.author!.photo!.replacingOccurrences(of: "webp", with: "png")))
            
            /// 设置作者名称
            name.text = dish.author?.name
            titleLabel.text = dish.title
            
            /// 设置正文标题，如果没标题的话，修改动态布局
            if dish.title?.count == 0{
                titleLabel.isHidden = true
                aritcleYLayout.priority = UILayoutPriority(rawValue: 1)
            }else{
                titleLabel.isHidden = false
                aritcleYLayout.priority = UILayoutPriority(rawValue: 1000)
            }
            
            /// 设置正文并动态设置正文高度
            articleLabel.text = dish.desc
            aritcleHeightLayout.constant = (articleLabel.text?.sizeWithText(font: articleLabel.font).height)! + 10
            
            /// 动态设置底部话题按钮宽度
            topicButton.setTitle(dish.name, for: .normal)
            topicButtonLayout.constant = (dish.name?.sizeWithText(font:topicButton.titleLabel?.font).width)! + 20
            
            /// 设置照片
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
            
            /// 设置点赞数，评论数，收藏数
            likeNumber.text = "\(dish.ndiggs!)"
            commentNumber.text = "\(dish.ncomments!)"
            collecNumber.text = "\(dish.n_collects!)"
            timeLabel.text = dish.friendly_create_time
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.layer.cornerRadius = 25
        iconView.layer.masksToBounds = true
        
        
    }
}

extension HMHomeFollowCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dish.extra_pics!.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        
        
        let imageView = UIImageView.init()
        
        if(indexPath.row == 0){
            let url = dish.photo?.replacingOccurrences(of: "webp", with: "png")
            imageView.kf.setImage(with: URL(string: url!))
        }else{
            let url = dish.extra_pics![indexPath.row - 1].url?.replacingOccurrences(of: "webp", with: "png")
            imageView.kf.setImage(with: URL(string: url!))
        }
        
        
        
        cell.contentView.addSubview(imageView)
        cell.backgroundColor = .blue
        
        return cell
    }
    
    
}
