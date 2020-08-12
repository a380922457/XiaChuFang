//
//  HMRecipeStepCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/11.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import IBAnimatable

class HMRecipeStepCell: UITableViewCell {
    
    var curIndex: Int?
    
    var model: HMRecipeDetailModel?{
        didSet{
            stepLabel.text = "步骤 \(curIndex!)"
            
            my_textLabel.text = model!.steps[curIndex! - 1].0
            
            my_imageView.kf.setImage(with: URL(string: model!.steps[curIndex! - 1].1))
            
            labelHeight.constant = (my_textLabel.text?.sizeWithText(font: .systemFont(ofSize: 19), size: CGSize(width: YYScreenWidth - 50, height: 0)).height)! + 10
            
            imageHeight.constant = min((YYScreenWidth - 50) * CGFloat(model!.steps[curIndex! - 1].2), 300)
            
            if imageHeight.constant == 0{
                imageTop.constant = 0
            }
        }
    }
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var my_imageView: AnimatableImageView!
    @IBOutlet weak var my_textLabel: UILabel!
    @IBOutlet weak var separationLine: UIView!

    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imageTop: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
