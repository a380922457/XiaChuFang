//
//  TabBar.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/26.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMTabBar: UITabBar {
    
    // 上一个被选中的Button，默认第一个
    var selectedButton: UIButton?

    override func layoutSubviews() {
        self.backgroundColor = .white
        
//         1.移除原生tabBarButton
        for item in subviews{
            if !item.isKind(of: NSClassFromString("UITabBarButton")!){
                continue
            }
            item.removeFromSuperview()
        }

//         2.设置自定义button
        var i: CGFloat = 0
        let buttonW = YYScreenWidth / CGFloat(items!.count)
        let buttonH: CGFloat = 48
        for item in items!{
            let button = HMTabBarButton(frame: CGRect(x: i * buttonW, y: 0, width: buttonW, height: buttonH), item: item)
            button.tag = Int(i)
            button.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
            addSubview(button)
            if i == 0{
                // 默认选中第一个button
                clickButton(button: button)
                selectedButton = button
            }
            i += 1
        }
    }
    
    @objc func clickButton(button: UIButton){
        
        // 更换选中按钮
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
        
        // 通知tabbarController切换控制器
        (delegate as! UITabBarController).selectedIndex = button.tag
    }
    
}

