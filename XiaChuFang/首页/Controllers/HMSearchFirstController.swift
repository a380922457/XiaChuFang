//
//  HMSearchFirstController.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/6.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class HMSearchFirstController: UICollectionViewController {
    var titleView: HMNavSearchView?
    
    // 加载流行搜索数据
    lazy var popularSearchs: [String] = {
        let diaryList:String = Bundle.main.path(forResource: "popularSearch", ofType:"plist")!
        return NSArray(contentsOfFile:diaryList) as! [String]
    }()
    
    // 加载最近搜索数据
    var recentSearchs: [String] = {
        if let array = UserDefaults.standard.object(forKey: "recentSearchs"){
            return array as! [String]
        }
        return [String]()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavUI()
        collectionView.backgroundColor = .white
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        let layout = collectionViewLayout as! HMSearchFirstLayout
        layout.recentSearchs = recentSearchs
        layout.popularSearchs = popularSearchs
        
        // 默认搜索红烧肉
        (navigationItem.titleView as! HMNavSearchView).searchLabel.text = "红烧肉"
        search()
        
        // 监听清空按钮
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "clear"), object: nil, queue: nil) { (notification) in
            self.recentSearchs.removeAll()
            UserDefaults.standard.set(self.recentSearchs, forKey: "recentSearchs")
            layout.recentSearchs = nil
            self.collectionView.reloadData()
        }
    }
   
}

// 设置导航条
extension HMSearchFirstController{
    func setupNavUI(){
       // 设置导航条内容
       let titleView = HMNavSearchView.loadFromNib()
       navigationItem.titleView = titleView
       titleView.frame = CGRect(x: 0, y: 0, width: (YYScreenWidth) - 140, height: 40)
       titleView.delegate = self
       titleView.searchLabel.becomeFirstResponder()
       titleView.searchLabel.delegate = self
       titleView.searchLabel.addTarget(self, action: #selector(self.textChange(_:)), for: UIControl.Event.editingChanged)
       self.titleView = titleView
       
       let left = UIBarButtonItem.init(image: UIImage.init(named: "backStretchBackgroundNormal"), style: .plain, target: self, action: #selector(self.back))
       navigationItem.leftBarButtonItem = left
       
       let right = UIBarButtonItem.init(title: "搜索", style: .plain, target: self, action: #selector(self.search))
       right.tintColor = .red
       navigationItem.rightBarButtonItem = right
       navigationController?.navigationBar.barTintColor = .white
       navigationController?.navigationBar.backgroundColor = .white
    }

    @objc func back(){
       navigationController?.popViewController(animated: false)
    }

    @objc func search(){
       let textField = (navigationItem.titleView as! HMNavSearchView).searchLabel
       if textField!.text!.count == 0 {return}
       let secondVc = HMSearchSecondController(keyword: textField!.text!)
       navigationController?.pushViewController(secondVc, animated: false)
    }
}


// MARK: 实现collectionView数据源和代理方法
extension HMSearchFirstController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let layout = collectionViewLayout as! HMSearchFirstLayout
        return section == 0 ? layout.attrs0.count : layout.attrs1.count
    }

    // 设置cell数据
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
                
        var text = ""
        if indexPath.section == 0{
            text = recentSearchs[indexPath.row]
        }else{
            text = popularSearchs[indexPath.row]
        }
        
        let x = 0, y = 0, height = 30
        let width = text.sizeWithText(font: UIFont.systemFont(ofSize: 20)).width
        let button = UIButton.init(frame: CGRect(x: x, y: y, width: Int(width + 20), height: height))
        button.setTitle(text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.init(r: 240, g: 240, b: 240)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(self.searchWithButton(button:)), for: .touchUpInside)
        
        cell.contentView.addSubview(button)
        
        return cell
    }
    
    // 点击搜索按钮
    @objc func searchWithButton(button: UIButton){
        let text = button.titleLabel!.text!
        titleView?.searchLabel.text = text
        if let i = recentSearchs.firstIndex(of: text){recentSearchs.remove(at: i)}
        
        // 添加最近搜索
        recentSearchs.insert(text, at: 0)
        UserDefaults.standard.set(recentSearchs, forKey: "recentSearchs")
        search()
    }
}


// MARK: UITextField的代理方法
extension HMSearchFirstController: UITextFieldDelegate, HMNavSearchViewDelegate{
    
    // 点击搜索图标
    func clickSearchButton() {titleView!.searchLabel?.becomeFirstResponder()}

    // 点击return按钮
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search()
        return true
    }

    // 监听文字改变
    @objc func textChange(_ textField: UITextField) {
        let clearButton = (navigationItem.titleView as! HMNavSearchView).clearButton
        let scanButton = (navigationItem.titleView as! HMNavSearchView).scanButton
        clearButton?.isHidden = textField.text?.count == 0
        scanButton?.isHidden = textField.text?.count != 0
    }
    
}
