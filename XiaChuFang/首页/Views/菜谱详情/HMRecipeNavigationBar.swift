//
//  HMRecipeNavigationBar.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/10.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMRecipeNavigationBar: UIView, NibLoadable {
    
    var delegate: UIViewController?
    
    static var statusBar = { () -> UIView in 
        let statusBar = UIView.init(frame: (UIApplication.shared.windows[0].windowScene?.statusBarManager!.statusBarFrame)!)
        UIApplication.shared.windows[0].addSubview(statusBar)
        return statusBar
    }()
    
    @IBAction func clickBack(_ sender: Any) {
        delegate?.navigationController?.popViewController(animated: false)
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var wxButton: UIButton!
    @IBOutlet weak var pyqButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    func changeDarkColor(){
        backButton.tintColor = .black
        wxButton.tintColor = .black
        pyqButton.tintColor = .black
        moreButton.tintColor = .black
        self.backgroundColor = .white
        
        HMRecipeNavigationBar.statusBar.backgroundColor = .white
    }
    
    func changeLightColor(){
        backButton.tintColor = .white
        wxButton.tintColor = .white
        pyqButton.tintColor = .white
        moreButton.tintColor = .white
        self.backgroundColor = .clear
        
        HMRecipeNavigationBar.statusBar.backgroundColor = .clear
    }
    
    
}
