//
//  HMNavSearchView.swift
//  豆瓣
//
//  Created by 梁航铭 on 2020/7/27.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import IBAnimatable

protocol HMNavSearchViewDelegate : class{
    func clickSearchButton()
    func clickSearchLabel()
    
}
extension HMNavSearchViewDelegate{
    func clickSearchLabel(){}
}


class HMNavSearchView: UIView, NibLoadable {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchLabel: UITextField!
    weak var delegate: HMNavSearchViewDelegate?
    @IBAction func clickSearchButton(_ sender: Any) {
        delegate?.clickSearchButton()
    }
    
    @IBAction func clickClearButton(_ sender: Any) {
        searchLabel.text = nil
    }
    override func awakeFromNib() {
        searchLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.clickSearchLabel)))
        contentView.backgroundColor = UIColor.init(r: 240, g: 240, b: 240)
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.size.width, height: bounds.size.height)
    }
    
    @objc func clickSearchLabel(){
        delegate?.clickSearchLabel()
    }
    
    @objc func jumpToSearchController(){
        delegate?.clickSearchButton()
    }
    
}
