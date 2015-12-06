//
//  ViewController.swift
//  OutletRenderer
//
//  Created by Keisuke.K on 2015/12/05.
//  Copyright © 2015年 keisuke. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate, CLLocationManagerDelegate, UIWebViewDelegate{

    
    // ボタンを用意
    var addBtn: UIBarButtonItem!
    
    //画面サイズ
    let screenRotationWidth = UIScreen.mainScreen().bounds.size.width
    let screenRotationHeight = UIScreen.mainScreen().bounds.size.height

    let statusBarHeight: CGFloat! = UIApplication.sharedApplication().statusBarFrame.height
    
    //現在地取得
    var myLocationManager:CLLocationManager!
    
    var webView: UIWebView?
    var targetURL = "http://taptappun.cloudapp.net/rental/?language=en-US&phone_number=ここに電話番号"
    var dateFormatter:NSDateFormatter = NSDateFormatter()
    
    var URLquery:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // タイトルを付けておきましょう
        self.title = "orenderer"
        
        // addBtnを設置
        addBtn = UIBarButtonItem(barButtonSystemItem: .Reply, target: self, action: "onClick")
        
        self.navigationItem.rightBarButtonItem = addBtn
        
        
        //使用言語を表示する
        let languages = NSLocale.preferredLanguages()
        print(languages)
        
        //連絡先を取得する
        contactAppLaunch()
        
        //現在地を取得する
        //getGpsInfo()
        
        URLquery = "?language=+en-US&phone_number=ここに電話番号"
        
        //WebViewの表示
        webViewFunction()
//        let url = NSURL(string: "orenderer://")
//        UIApplication.sharedApplication().openURL(url!)
//        print(url)
        
 
    }
    
    //連絡アプリを起動して電話番号を取得する
    func contactAppLaunch(){
        let pickerViewController = CNContactPickerViewController()
        pickerViewController.delegate = self
        
        let displayedItems = [CNContactPhoneNumbersKey]
        pickerViewController.displayedPropertyKeys = displayedItems
        
        // Show the pickerpickerViewController
        self.presentViewController(pickerViewController, animated: true, completion: nil)
    }

    //現在地の取得
    func getGpsInfo(){
        
        // 現在地を取得します
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = 100
        myLocationManager.startUpdatingLocation()
        
    }
    
    
    //WebViewの表示
    func webViewFunction(){

        // WebViewを生成する
        self.webView = self.createWebView(frame: CGRectMake(0, 0, screenRotationWidth, screenRotationHeight))
        //webView?.delegate = self
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
    
    
    //ページを読み始めた時に呼ばれる関数
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    //ページが読み終わったときに呼ばれる関数
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        let contactName = CNContactFormatter.stringFromContact(contact, style: .FullName) ?? ""
        let propertyName = CNContact.localizedStringForKey(contactProperty.key)
        let title = "\(contactName)'s \(propertyName)"
        let tel = contactProperty.value
        
        //電話番号の取得
        print(tel)
        
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: title,
                message: "+818055146460",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    // WebView を生成する
    func createWebView(frame frame: CGRect) -> UIWebView {
        
        // UIWebViewのインスタンスを生成
        let webView = UIWebView()
        webView.delegate = self
        webView.frame = frame
        
        return webView
    }
    
    
    func format(date : NSDate, style : String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = style
        return  dateFormatter.stringFromDate(date)
    }
    
    //func locationManager
    
    // 位置情報取得成功時に呼ばれます
//    func locationManager(manager: CLLocationManager!,didUpdateLocations locations: [AnyObject]!){
//        
//        print("緯度：\(manager.location?.coordinate.latitude)")
//        print("\(manager.location?.coordinate.longitude)")
//    }
    
    // 位置情報取得失敗時に呼ばれます
    func locationManager(manager: CLLocationManager!,didFailWithError error: NSError!){
        print("error")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // addBtnをタップしたときのアクション
    func onClick() {
        
        self.webView!.goBack()
        
    }


}

