//
//  HMCommentTableView.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/4.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

class HMCommentTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
    }
    
    @IBOutlet weak var commentTableViewHeightLayout: NSLayoutConstraint!

    var model: HMDishModel?{
        didSet{
            // 动态设置评论tableview高度,刷新tableView
            let count = model!.latest_comments!.count
            if count == 0{
                commentTableViewHeightLayout.constant = 0
            }else if count > 3{
                commentTableViewHeightLayout.constant = 20 * 5
            }else{
                commentTableViewHeightLayout.constant = CGFloat(20 * (count + 1))
            }
            
            // 添加headerView作为分隔线
            if count == 0{
                tableHeaderView = nil
            }else{
                // header
                let sepView = UIView(frame: CGRect(x: 10, y: 0, width: YYScreenWidth - 20, height: 12))
                let subView = UIView(frame: CGRect(x: 0, y: 0.5, width: YYScreenWidth - 20, height: 0.5))
                sepView.addSubview(subView)
                subView.backgroundColor = UIColor.init(r: 225, g: 225, b: 225)
                tableHeaderView = sepView
            }
            
            // 添加footerView
            if count <= 3{
                tableFooterView = nil
            }else{
                // footer
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
                label.textColor = .lightGray
                label.text = "共\(model!.ncomments!)条评论"
                label.font = .systemFont(ofSize: 13)
                tableFooterView = label
            }
            self.reloadData()
        }
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(3, model?.latest_comments?.count ?? 0)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: YYScreenWidth - 20, height: 20))
        label.font = .systemFont(ofSize: 14)
        cell.addSubview(label)
        
        let comment: HMComment = model!.latest_comments![indexPath.row]
        let string = comment.author!.name! + ": " + comment.txt!
        let attrString = NSMutableAttributedString.init(string: string)
        attrString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)], range: NSRange.init(location: 0, length: comment.author!.name!.count))
        
        label.attributedText = attrString
        
        return cell
        
    }

}
