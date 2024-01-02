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
    }

}

extension WebViewViewController : WKNavigationDelegate {

}
