//
//  HomeViewController.swift
//  trainingiOS
//
//  Created by DucDo on 29/12/2023.
//

import UIKit
import GoogleSignIn
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func passingData(_ sender: UIButton) {
        let vc = PassingDataViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func webView(_ sender: UIButton) {
        let vc = WebViewViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func myWebView(_ sender: UIButton) {
        let vc = MyWebViewViewController()
        self.navigationController!.present(vc, animated: true)
    }
    
    @IBAction func realtimeDatabase(_ sender: UIButton) {
        let vc = RealtimeDatabaseViewController()
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func firebase(_ sender: UIButton) {
        if GIDSignIn.sharedInstance.currentUser != nil {
            let vc = HomeFirebaseViewController()
            self.navigationController!.pushViewController(vc, animated: true)
        } else {
            let vc = LoginWithGGViewController()
            self.navigationController!.pushViewController(vc, animated: true)
        }
        
    }
}
