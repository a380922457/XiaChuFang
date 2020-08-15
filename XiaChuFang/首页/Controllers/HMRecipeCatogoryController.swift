//
//  CollectionViewController.swift
//  XiaChuFang
//
//  Created by 梁航铭 on 2020/8/5.
//  Copyright © 2020 梁航铭. All rights reserved.
//

import UIKit
import WebKit

class HMRecipeCatogoryController: UIViewController {
    
    @objc func back(){
        navigationController?.popViewController(animated: false)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        let item = UIBarButtonItem.init(image: UIImage.init(named: "backStretchBackgroundNormal"), style: .plain, target: self, action: #selector(self.back))
        navigationItem.leftBarButtonItem = item

        title = "菜谱分类"

        let webView = WKWebView.init(frame:self.view.frame)
        webView.navigationDelegate = self
        self.view.addSubview(webView)

        webView.load(URLRequest(url: URL(string: "https://www.xiachufang.com/page/app-category/")!))

    }
}

extension HMRecipeCatogoryController:WKNavigationDelegate{
    // 拦截请求，跳转到搜索控制器
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        let string = navigationAction.request.url!.absoluteString
        if !string.starts(with: "https://www.xiachufang.com/search"){
            return
        }
        let keyword = string.split(separator: "=")[1].removingPercentEncoding!
        let vc = HMSearchSecondController(keyword: keyword)
        navigationController?.pushViewController(vc, animated: false)
    }
}
