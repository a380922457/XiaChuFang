//
//  HMRecipeHeaderView.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/9.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import IBAnimatable

class HMRecipeHeaderCell: UITableViewCell{

    var model: HMRecipeDetailModel?{
        didSet{
            
            imageVIew.kf.setImage(with: URL(string:model!.imageUrl!))
            
            doneNumLabel.text = model?.doneNumber
            
            titleLabel.text = model?.title
            
            authorImageView.kf.setImage(with: URL(string: model!.authorImageUrl!))
            
            nameLabel.text = model?.authorName
            
            timeLabel.text = model?.createTime
            
            my_textLabel.text = model?.text
            
            rateLabel.text = "\(model!.rate ?? "")\(model!.collectionNumber!)收藏 ·  \(model!.viewedNumber!)次浏览"
            
            vipView.isHidden = !model!.isShowIcon
            
            imageHeight.constant = min(YYScreenWidth * CGFloat(model!.imageRatio!), YYScreenHeigth * 0.6)
                        
            textHeight.constant = ((model?.text?.sizeWithText(font: .systemFont(ofSize: 19), size: CGSize(width: YYScreenWidth - 50, height: 0)).height) ?? 0) + 10
            
            nameWidth.constant = (model?.authorName?.sizeWithText(font: .systemFont(ofSize: 19)).width)! + 10
            
            collectionNumWidth.constant = (model?.collectionNumber?.sizeWithText(font: .systemFont(ofSize: 13)).width)!
            
            collectionContainer.backgroundColor = UIColor.init(r: 120, g: 120, b: 120, alpha: 0.4)
                        
            self.selectionStyle = .none

        }
    }
    @IBOutlet weak var vipView: UIImageView!
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    @IBOutlet weak var doneNumLabel: UILabel!
    
    @IBOutlet weak var collectionContainer: AnimatableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var my_textLabel: AnimatableLabel!
    
    @IBOutlet weak var authorImageView: AnimatableImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var textHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nameWidth: NSLayoutConstraint!
    
    @IBOutlet weak var collectionNumWidth: NSLayoutConstraint!
}
