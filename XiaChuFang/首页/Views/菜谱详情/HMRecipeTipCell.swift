//
//  HMRecipeTipCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/11.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMRecipeTipCell: UITableViewCell {
    var model: HMRecipeDetailModel?{
        didSet{
            my_textLable.text = model!.smallTip
            
            if model!.smallTip == nil {return}
             
            labelHeight.constant = (my_textLable.text?.sizeWithText(font: .systemFont(ofSize: 17), size: CGSize(width: YYScreenWidth - 100, height: 0)).height)! + 10
            
        }
    }
    
    @IBOutlet weak var my_contentView: UIView!
    @IBOutlet weak var my_textLable: UILabel!
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
