//
//  HMGoLoginController.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/28.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMGoLoginController: UIViewController {

    @IBOutlet weak var goLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goLoginButton.layer.cornerRadius = 10
        goLoginButton.layer.borderColor = globalColor.cgColor
        goLoginButton.layer.borderWidth = 1
    }


}
