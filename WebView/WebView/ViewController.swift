//
//  ViewController.swift
//  WebView
//
//  Created by dam2 on 1/2/24.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        let url = URL(string: "https://itedeveloper.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    
    
    @IBAction func backBtn(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func fwdBtn(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func refresh(_ sender: Any) {
        webView.reload()
    }
}

