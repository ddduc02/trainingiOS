//
//  HomeFirebaseViewController.swift
//  trainingiOS
//
//  Created by DucDo on 03/01/2024.
//

import UIKit
import GoogleSignIn
import FirebaseStorage

class HomeFirebaseViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var activityIndicator: UIActivityIndicatorView!
    var latestImageUploaded : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pickImage(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        uploadImageToFirebase(image: imageView.image!)
    }
    
    @IBAction func download(_ sender: UIButton) {
        downloadImage()
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signOut()
        let vc = LoginWithGGViewController()
        var viewController = self.navigationController?.viewControllers
        viewController?.removeLast()
        viewController?.append(vc)
        navigationController?.setViewControllers(viewController!, animated: true)
    }
    
    func uploadImageToFirebase(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let imageID = UUID()
        latestImageUploaded = "\(imageID)"
        let storageRef = Storage.storage().reference().child("images")
        
        let imageRef = storageRef.child(latestImageUploaded!)
        print(imageRef)
        
        let uploadTask = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                return
            }
        }
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        uploadTask.observe(.progress) { [self] snapshot in
            activityIndicator.startAnimating()
        }
        
        uploadTask.observe(.success) { snapshot in
            self.imageView.image = UIImage(systemName: "photo")
            self.activityIndicator.stopAnimating()
        }
        
        uploadTask.observe(.failure) { snapshot in
        }
    }
    
    func downloadImage() {
        
        let pathReference = Storage.storage().reference(withPath: "images/")
        let imageRef = pathReference.child(latestImageUploaded!)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        let check = imageRef.getData(maxSize: 1 * 1024 * 1024) { [self] data, error in
            if error != nil {
                
            } else {
                let image = UIImage(data: data!)
                imageView.image = image
            }
        }
        check.observe(.progress) { data in
            self.activityIndicator.startAnimating()
        }
        
        check.observe(.success) { data in
            self.activityIndicator.stopAnimating()
        }
        check.observe(.failure) { data in
            print("error")
            self.activityIndicator.stopAnimating()
        }
    }
}

extension HomeFirebaseViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
            
            picker.dismiss(animated: true)
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    
}
