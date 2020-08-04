//
//  HMHomeFollowCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/7/29.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import KingfisherWebP
import Kingfisher



open class HMHomeFollowCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var collectionView: HMHomeFollowCollectionView!
    @IBOutlet weak var topicButton: UIButton!
    
    @IBOutlet weak var likeNumber: UILabel!
    @IBOutlet weak var commentNumber: UILabel!
    @IBOutlet weak var collecNumber: UILabel!
    @IBOutlet weak var commentTableView: HMCommentTableView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var aritcleYLayout: NSLayoutConstraint!
    @IBOutlet weak var aritcleHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var topicButtonLayout: NSLayoutConstraint!
    
    var dish: HMDishModel!
    
    var model: HMHomeFollowModel?{
        didSet{
            KingfisherManager.shared.defaultOptions += [
              .processor(WebPProcessor.default),
              .cacheSerializer(WebPSerializer.default)
            ]
            
            dish = model!.dish!
            
            // 设置作者头像
            iconView.kf.setImage(with: URL(string: dish.author!.photo!))
            
            // 设置作者名称
            name.text = dish.author?.name
            titleLabel.text = dish.title
            
            // 设置正文标题，如果没标题的话，修改动态布局
            if dish.title?.count == 0{
                titleLabel.isHidden = true
                aritcleYLayout.priority = UILayoutPriority(rawValue: 1)
            }else{
                titleLabel.isHidden = false
                aritcleYLayout.priority = UILayoutPriority(rawValue: 1000)
            }
            
            // 设置正文并动态设置正文高度
            articleLabel.text = dish.desc
            aritcleHeightLayout.constant = (articleLabel.text?.sizeWithText(font: articleLabel.font).height)! + 10
            
            // 动态设置底部话题按钮宽度
            topicButton.setTitle(dish.name, for: .normal)
            topicButtonLayout.constant = (dish.name?.sizeWithText(font:topicButton.titleLabel?.font).width)! + 20
            
            // 刷新九宫格collectionView数据
            collectionView.model = dish
            
            // 设置评论tableView数据
            commentTableView.model = dish
            
            // 设置点赞数，评论数，收藏数
            likeNumber.text = dish.ndiggs! == 0 ? "点赞" : "\(dish.ndiggs!)"
            commentNumber.text = dish.ncomments! == 0 ? "评论" : "\(dish.ncomments!)"
            collecNumber.text = dish.n_collects! == 0 ? "收藏" : "\(dish.n_collects!)"
            
            // 设置时间
            timeLabel.text = dish.friendly_create_time
            
        }
    }
    
}

