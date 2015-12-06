//
//  ViewController.swift
//  OutletRenderer
//
//  Created by Keisuke.K on 2015/12/05.
//  Copyright © 2015年 keisuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var webView: UIWebView?
    var targetURL = "https://www.google.co.jp/"
    var dateFormatter:NSDateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let languages = NSLocale.preferredLanguages()
        
        //使用言語を取得する
        print(languages)
        
        
        // 横幅、高さ、ステータスバーの高さを取得する
        let width: CGFloat! = self.view.bounds.width
        let height: CGFloat! = self.view.bounds.height
        let statusBarHeight: CGFloat! = UIApplication.sharedApplication().statusBarFrame.height
        

        // WebViewを生成する
        self.webView = self.createWebView(frame: CGRectMake(0, statusBarHeight, width, height - statusBarHeight))
        
        // サブビューを追加する
        self.view.addSubview(self.webView!)
        
        // リクエストを生成する
        var url = NSURL(string: targetURL)
        var request = NSURLRequest(URL: url!)
        
        // インジケータを表示する
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // 指定したページを読み込む
        self.webView?.loadRequest(request)
        
 
    }
    

    
    
    // WebView を生成する
    func createWebView(frame frame: CGRect) -> UIWebView {
        
        // UIWebViewのインスタンスを生成
        let webView = UIWebView()
        //selfに指定しないとwebViewDidStartLoadとwebViewDidFinishLoadが使用できない
        //webView.delegate = self
        // 画面サイズを設定する
        webView.frame = frame
        
        return webView
    }
    
    
    func webViewDidStartLoad(webView: UIWebView){
        // インジケータを表示する
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
    }
    
    // WebView がコンテンツの読み込みを完了した後に呼ばれる
    func webViewDidFinishLoad(webView: UIWebView) {
        // インジケータを非表示にする
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func format(date : NSDate, style : String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = style
        return  dateFormatter.stringFromDate(date)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

