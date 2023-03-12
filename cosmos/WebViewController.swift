//
//  WebViewController.swift
//  cosmos
//
//  Created by wshaolin on 2023/3/5.
//

import UIKit
import CommonUI

class WebViewController : CMBaseViewController, WebViewDelegate {
    private var webView: WebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WebView()
        webView.delegate = self;
        
        let webView_X: CGFloat = 0;
        let webView_Y: CGFloat = self.navigationBar.bounds.height
        let webView_W: CGFloat = self.view.bounds.width - webView_X * 2
        let webView_H: CGFloat = self.view.bounds.height - webView_Y
        webView.frame = CGRect(x: webView_X, y: webView_Y, width: webView_W, height: webView_H)
        
        self.view.addSubview(webView)
        self.webView = webView
        self.loadRequest();
    }
    
    func loadRequest() {
        let request = URLRequest(url: URL(string: "http://t.pae.baidu.com/s?s=bai-upw2mw")!)
        self.webView?.load(request)
    }
    
    func webView(_ webView: WebView, shouldStartLoad request: URLRequest, navigationType: WKNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: WebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: WebView) {
        webView.evaluateJavaScript("document.title") { (data: Any?, error: Error?) in
            if let title = data {
                print("document.title = \(title)")
                self.title = (title as! String)
            }
        }
    }
    
    func webView(_ webView: WebView, didFailLoad error: Error) {
        
    }
    
    func webView(_ webView: WebView, didLongPressImage image: String) {
        
    }
}
