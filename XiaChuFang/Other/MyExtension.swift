//
//  MyExtension.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/27.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import Foundation
import UIKit

let globalColor = UIColor.init(r: 103, g: 185, b: 98)

extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}

protocol NibLoadable{
    
}

extension NibLoadable where Self : UIView {
    static func loadFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! Self
    }
}


extension String{

    func sizeWithText(font: UIFont?, size: CGSize = CGSize.init(width: YYScreenWidth, height: 0)) -> CGSize {
    let attributes = [NSAttributedString.Key.font: font]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let rect:CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size;
    }

}
