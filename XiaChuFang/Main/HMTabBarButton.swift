//
//  TabBarButton.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/26.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMTabBarButton: UIButton {
    
    // 禁用高亮状态
    override var isHighlighted: Bool{
        get {
            return false
        }
        set{
        }
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 19, y: 10, width: 30, height: 30)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 10, y: 25, width: 50, height: 50)
    }


    
    
    convenience init(frame: CGRect, item: UITabBarItem) {
        self.init(frame: frame)
        
        setTitle(item.title, for: .normal)
        setTitleColor(.black, for: .normal)
        setTitleColor(.red, for: .selected)
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        titleLabel?.textAlignment = .center
        
        setImage(item.image, for: .normal)
        setImage(item.selectedImage, for: .selected)
    }
}
