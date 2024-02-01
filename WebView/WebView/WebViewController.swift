//
//  WebViewController.swift
//  Webview
//  :P
//  Created by dam2 on 1/2/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
 
    let webView = WKWebView()
    
    var progressView: UIProgressView!
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        webView.allowsBackForwardNavigationGestures = true
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), context: nil)
        
        webView.load("https://www.escuelaestech.es")
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Abrir", style: .plain, target: self, action: #selector(abrirMenu))
        
        
        let goBackBtn = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let goFwdBtn = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        //Barra de progreso
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressBtn = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [goFwdBtn, goBackBtn, spacer, progressBtn, refresh]
        
        navigationController?.isToolbarHidden = false
        
        // Cargar la web desde un fichero en el proyecto
        //        if let web = Bundle.main.url(forResource: "web", withExtension: "html") {
        //            webView.loadFileURL(web, allowingReadAccessTo: web.deletingLastPathComponent())
        //        }
        
        // Cargar html desde una variable
        //        let html = """
        //                        <html>
        //                            <body>
        //                                <h1>Hola EsTech</h1>
        //                                <ol>
        //                                    <li>Una cosa</li>
        //                                    <li>Otra cosa</li>
        //                                </ol>
        //                            </body>
        //                        </html>
        //                    """
        //        webView.loadHTMLString(html, baseURL: nil)
        
    }
    
    
    @objc func abrirMenu(){
        let ac = UIAlertController(title: "Abrir página web", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Escuela Estech", style: .default, handler: openPage(action:)))
        ac.addAction(UIAlertAction(title: "google.com", style: .default, handler: openPage(action:)))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action:UIAlertAction){
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        //leer historial
        /* for page in webView.backForwardList.backList{
         print("EL usuario ha visitado \(page.url.absoluteString)")
         }*/
        //hasta aqui leer historial
        
        
        
        if let host = navigationAction.request.url?.host() {
            if host.contains("apple.com") {
                UIApplication.shared.open(navigationAction.request.url!)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            //print(Float(webView.estimatedProgress))
            //progressView.progress = Float(webView.estimatedProgress)
        } else if keyPath == "title" {
            print(webView.title)
            self.navigationItem.title = webView.title
        }
    }
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        } else {

        }
    }
}
