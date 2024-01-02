//
//  PassingDataViewController.swift
//  trainingiOS
//
//  Created by DucDo on 29/12/2023.
//

import UIKit

protocol DataDelegate : AnyObject {
    func sendData(itemName : String, number : Int)
}

class PassingDataViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    var itemName : String = "Bim Bim"
    let lable : String = "Số lượng"
    var number : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = itemName
        quantity.text = lable + " \(number)"
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        let vc = ReceivingViewController()
        vc.name = itemName
        vc.quantity = number
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
    
}

extension PassingDataViewController : DataDelegate {
    func sendData(itemName: String, number: Int) {
        print("Ok2")
        self.itemName = itemName
        self.number = number
        self.name.text = self.itemName
        quantity.text = lable + " \(number)"
        
    }
}
