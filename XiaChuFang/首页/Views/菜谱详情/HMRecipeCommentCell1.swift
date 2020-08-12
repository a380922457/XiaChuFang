//
//  HMRecipeCommentCell1.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/11.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import IBAnimatable

class HMRecipeCommentCell1: UITableViewCell {
    var model: HMRecipeDetailModel?{
        didSet{
            authorNameLabel.text = model?.comments[curIndex!].authorName ?? "乐观的皮皮狗"
            
            my_textLabel.text = model?.comments[curIndex!].authorText
            
            iconView.kf.setImage(with: URL(string: model!.comments[curIndex!].authorImageUrl ?? ""))
            
            likeNumLabel.text = model?.comments[curIndex!].likeNumber
            
            let width = my_textLabel.frame.width
            textHeight.constant = my_textLabel.text!.sizeWithText(font: .systemFont(ofSize: 16), size: CGSize(width: width, height: 0)).height + 10
                        
            likeNumWidth.constant = likeNumLabel.text!.sizeWithText(font: .systemFont(ofSize: 13)).width + 2
            
        }
    }
    
    var curIndex: Int?

    @IBOutlet weak var iconView: AnimatableImageView!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet weak var likeNumLabel: UILabel!
    
    @IBOutlet weak var likeNumWidth: NSLayoutConstraint!
    
    @IBOutlet weak var my_textLabel: UILabel!
    
    @IBOutlet weak var textHeight: NSLayoutConstraint!
    
    @IBOutlet weak var replyContentView: UIView!
    
    @IBOutlet weak var replyLikeNumLabel: UIView!
    
    @IBOutlet weak var replyLikeWidth: NSLayoutConstraint!
    
    @IBOutlet weak var replayAuthorNameLabel: UILabel!
    
    @IBOutlet weak var replyTextLabel: UILabel!
    
    @IBOutlet weak var replyTextHeight: NSLayoutConstraint!
    
    @IBOutlet weak var replyContentHeight: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
