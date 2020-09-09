//
//  HMRecipeGradientsCell.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/10.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import IBAnimatable


class HMRecipeGradientsCell: UITableViewCell {

    var heights = [CGFloat]()
    var model: HMRecipeDetailModel?{
        didSet{
            var height: CGFloat = 0
            
            for i in 0..<(model?.gradients.count ?? 0){
                let width: Int = Int(gradientsTableView.bounds.width)
                let lHeight = (model?.gradients[i].0.sizeWithText(font: .systemFont(ofSize: 19), size: CGSize(width: width, height: 0)).height)! + 40
                let rHeight = (model?.gradients[i].1.sizeWithText(font: .systemFont(ofSize: 19), size: CGSize(width: width, height: 0)).height)! + 40
                let curHeight = max(lHeight, rHeight)
                heights.append(curHeight)
                height += curHeight
            }
            
            tableViewHeight.constant = height + 20
            gradientsTableView.reloadData()
            
        }
    }
    
    @IBOutlet weak var gradientsTableView: UITableView!
    @IBAction func clickVegButton(_ sender: Any) {
    }
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var vegetableButton: AnimatableButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        vegetableButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
        vegetableButton.setTitleColor(UIColor.init(r: 110, g: 110, b: 110, alpha: 1), for: .normal)
        
        gradientsTableView.isScrollEnabled = false
        gradientsTableView.delegate = self
        gradientsTableView.dataSource = self
        gradientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
}

extension HMRecipeGradientsCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.gradients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        for sub in cell.contentView.subviews {sub.removeFromSuperview()}
        
        let width: Int = Int(tableView.bounds.width)
      
        let gradientLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width / 2, height: Int(heights[indexPath.row])))
        gradientLabel.text = model?.gradients[indexPath.row].0
        gradientLabel.font = .systemFont(ofSize: 19)
        gradientLabel.textColor = UIColor.init(r: 66, g: 66, b: 66, alpha: 1)
        gradientLabel.numberOfLines = 0
    
        let unitLabel = UILabel(frame: CGRect(x: width / 2 + 15, y: 0, width: width / 2, height: Int(heights[indexPath.row])))
        unitLabel.text = model?.gradients[indexPath.row].1
        unitLabel.font = .systemFont(ofSize: 19)
        unitLabel.textColor = UIColor.init(r: 66, g: 66, b: 66, alpha: 1)
        unitLabel.numberOfLines = 0
        
        cell.contentView.addSubview(gradientLabel)
        cell.contentView.addSubview(unitLabel)
        
        // 添加虚线
        if indexPath.row != 0{
            cell.contentView.drawDashLine(cell.contentView, lineColor: UIColor.init(r: 210, g: 210, b: 210, alpha: 1))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath.row]
    }
    
}
