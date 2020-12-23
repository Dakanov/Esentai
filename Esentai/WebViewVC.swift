//
//  WebViewVC.swift
//  Esentai
//
//  Created by Sultan on 12/20/20.
//

import UIKit
import WebKit
import EasyPeasy

class WebViewVC: UIViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
   
    
    
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        webView.easy.layout(Edges())
        
        webViewSet()
       
    }
    func webViewSet(){
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        view.backgroundColor = UIColor(red: 219.0/255.0, green: 30.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        let url = URL(string: "https://esentai-shop.kz/")
        webView.configuration.userContentController.add(self, name: "bearer \(token)")
        var req = URLRequest(url: url!)
        req.httpMethod = "POST"
//        let urlConnection = NSURLConnection(request: req, delegate: self)
        
//        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        req.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        webView.load(req)
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print(message.name)
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        let configuration = WKWebViewConfiguration()
                return WKWebView(frame: webView.frame, configuration: configuration)

    }
}
