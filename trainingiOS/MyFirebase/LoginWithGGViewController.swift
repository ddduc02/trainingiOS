//
//  LoginWithGGViewController.swift
//  trainingiOS
//
//  Created by DucDo on 03/01/2024.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginWithGGViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGoogle()
        
    }
    
    func setUpGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            let vc = HomeFirebaseViewController()
            var viewController = self.navigationController?.viewControllers
            viewController?.removeLast()
            viewController?.append(vc)
            navigationController?.setViewControllers(viewController!, animated: true)
        }
        
    }
}

