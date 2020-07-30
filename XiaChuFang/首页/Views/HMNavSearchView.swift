//
//  HMNavSearchView.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/27.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMNavSearchView: UIView, NibLoadable {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var labelButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var messageButton: UIButton!
    override func awakeFromNib() {
        contentView.layer.cornerRadius = 5
        
    }
    
    
}
