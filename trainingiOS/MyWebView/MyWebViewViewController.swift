//
//  MyWebViewViewController.swift
//  trainingiOS
//
//  Created by DucDo on 02/01/2024.
//

import UIKit
import WebKit

class MyWebViewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let htmlPath = Bundle.main.path(forResource: "index", ofType: "html")
        let url = URL(filePath: htmlPath!)
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
