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
    // 页面开始加载时调用
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
//        self.navigationItem.title = "加载中..."
//        print("didStartProvisionalNavigation")
//    }
//    // 当内容开始返回时调用
//    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
//        print("didCommit")
//    }
//    // 页面加载完成之后调用
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
//        print("didFinish")
//    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        decisionHandler(.allow)
//        print(navigationAction.request.url)
//    }
    
    
}
