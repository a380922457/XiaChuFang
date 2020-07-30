//
//  HMNavigationController.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/27.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var childForStatusBarStyle: UIViewController?{
        return topViewController
    }
}
