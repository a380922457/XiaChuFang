//
//  HMRecipePeopleMakeCollectionCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/12.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import IBAnimatable

class HMRecipePeopleMakeCollectionCell: UICollectionViewCell {

    var model: HMPeople?{
        didSet{
            my_imageView.kf.setImage(with: URL(string: model!.imageUrl!))
            my_textLabel.text = model?.authorText
            timeLabel.text = model?.time
            iconView.kf.setImage(with: URL(string: model!.authorImageUrl!))
            authorNameLabel.text = model?.authorName
            likeNumberLabel.text = model?.likeNumber
            
            likeNumWidth.constant = (likeNumberLabel.text?.sizeWithText(font: .systemFont(ofSize: 12)).width ?? 0) + 2
        }
    }
    
    @IBOutlet weak var my_imageView: UIImageView!
    
    @IBOutlet weak var my_textLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var iconView: AnimatableImageView!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet weak var likeNumberLabel: UILabel!
    
    @IBOutlet weak var likeNumWidth: NSLayoutConstraint!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
