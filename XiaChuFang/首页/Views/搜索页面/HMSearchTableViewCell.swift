//
//  HMSearchTableViewCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/7.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMSearchTableViewCell: UITableViewCell {
    
    var model: HMSearchRecipeModel?{
        didSet{
            my_imageView.kf.setImage(with: URL(string: model!.imageUrl!)!)
            
            my_title.text = model!.title!
            
            my_rate.text = "\(String(describing: model!.rate ?? 0))分"
            
            my_number.text = "\(String(describing: model!.number ?? 0))人做过"
            
            my_author_name.text = model!.authorName!
                        
            numberHeight.constant = model?.number == nil ? 0 : 21
            
            rateHeight.constant = model?.rate == nil ? 0 : 21
            rateWidth.constant = model?.rate == nil ? 0 : 54
        }
    }
    
    @IBOutlet weak var numberHeight: NSLayoutConstraint!
    
    @IBOutlet weak var rateWidth: NSLayoutConstraint!
    @IBOutlet weak var rateHeight: NSLayoutConstraint!
    @IBOutlet weak var my_imageView: UIImageView!
    @IBOutlet weak var my_title: UILabel!
    @IBOutlet weak var my_rate: UILabel!
    @IBOutlet weak var my_number: UILabel!
    @IBOutlet weak var my_author_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
