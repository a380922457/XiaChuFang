//
//  HMRecipeCommentCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/11.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import IBAnimatable

class HMRecipeCommentCell: UITableViewCell {
    var model: HMRecipeDetailModel?{
        didSet{
            // 防止多次赋值model，重复计算
            if heights.count == model?.comments.count {return}
            for i in 0..<model!.comments.count{
                let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeCommentCell1") as! HMRecipeCommentCell1
                cell.curIndex = i
                cell.model = model
                cell.layoutIfNeeded()
                heights.append(cell.my_textLabel.frame.maxY)
            }
            tableViewHeight.constant = heights.reduce(0, +)
        }
    }
    var heights = [CGFloat]()

    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
       
    @IBOutlet weak var seeAllButton: UIButton!
   
    @IBOutlet weak var commentButton: AnimatableButton!
    
    
    @IBAction func clickSeeAllButton(_ sender: Any) {
    }
    @IBAction func clickCommentButton(_ sender: Any) {
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "HMRecipeCommentCell1", bundle: nil), forCellReuseIdentifier: "HMRecipeCommentCell1")
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .red
    }
}

extension HMRecipeCommentCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model!.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HMRecipeCommentCell1") as! HMRecipeCommentCell1
        cell.curIndex = indexPath.row
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath.row]
    }
}
