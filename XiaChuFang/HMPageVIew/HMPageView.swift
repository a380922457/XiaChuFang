//
//  HMPageView.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/28.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

public typealias TitleClickHandler = (HMPageTitleView, Int) -> ()
typealias ColorRGB = (red: CGFloat, green: CGFloat, blue: CGFloat)
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
//    convenience init?(hex: String, alpha: CGFloat = 1.0) {
//
//        guard hex.count >= 6 else {
//            return nil
//        }
//
//        var hexString = hex.uppercased()
//
//        if (hexString.hasPrefix("##") || hexString.hasPrefix("0x")) {
//
//            hexString = (hexString as NSString).substring(from: 2)
//        }
//
//        if (hexString.hasPrefix("#")) {
//
//            hexString = (hexString as NSString).substring(from: 1)
//        }
//
//
//        var range = NSRange(location: 0, length: 2)
//        let rStr = (hexString as NSString).substring(with: range)
//        range.location = 2
//        let gStr = (hexString as NSString).substring(with: range)
//        range.location = 4
//        let bStr = (hexString as NSString).substring(with: range)
//
//
//        var r: UInt32 = 0
//        var g: UInt32 = 0
//        var b: UInt32 = 0
//        Scanner(string: rStr).scanHexInt32(&r)
//        Scanner(string: gStr).scanHexInt32(&g)
//        Scanner(string: bStr).scanHexInt32(&b)
//
//        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), alpha: alpha)
//    }
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (red * 255, green * 255, blue * 255)
    }
}

class HMPageView: UIView {

    private (set) public var style: HMPageStyle
    private (set) public var titles: [String]
    private (set) public var childViewControllers: [UIViewController]

    private (set) public var titleView: HMPageTitleView
    private (set) public var contentView: HMPageContentView


    public init(frame: CGRect, style: HMPageStyle, titles: [String], childViewControllers: [UIViewController], startIndex: Int = 0) {
        self.style = style
        self.titles = titles
        self.childViewControllers = childViewControllers
        titleView = HMPageTitleView(frame: .zero, style: style, titles: titles, currentIndex: startIndex)
        contentView = HMPageContentView(frame: .zero, style: style, childViewControllers: childViewControllers, startIndex: startIndex)
        super.init(frame: frame)
        
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleViewHeight)
        addSubview(titleView)
        
        contentView.frame = CGRect(x: 0, y: style.titleViewHeight, width: bounds.width, height: bounds.height - style.titleViewHeight)
        contentView.backgroundColor = UIColor.white
        addSubview(contentView)
        
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}

