//
//  WebViewViewController.swift
//  trainingiOS
//
//  Created by DucDo on 02/01/2024.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
        webView.navigationDelegate = self
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(goBack))
        
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style: .plain, target: self, action: #selector(goForward))
        
        let reload = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(reload))
        
        navigationItem.rightBarButtonItems = [backButton, forwardButton, reload]
    }
    
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func reload() {
        webView.reload()
    }

}

extension WebViewViewController : WKNavigationDelegate {

}
