//
//  HomeFirebaseViewController.swift
//  trainingiOS
//
//  Created by DucDo on 03/01/2024.
//

import UIKit
import GoogleSignIn

class HomeFirebaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signOut()
        let vc = LoginWithGGViewController()
        var viewController = self.navigationController?.viewControllers
        viewController?.removeLast()
        viewController?.append(vc)
        navigationController?.setViewControllers(viewController!, animated: true)
    }
}
