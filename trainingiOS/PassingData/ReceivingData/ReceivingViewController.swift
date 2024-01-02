//
//  ReceivingViewController.swift
//  trainingiOS
//
//  Created by DucDo on 29/12/2023.
//

import UIKit

class ReceivingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var name : String = ""
    var quantity : Int = 0
    var delegate : DataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = name
        quantityLabel.text = "\(quantity)"
        stepper.value = Double(quantity)
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        print(sender.value)
        quantity = Int(sender.value)
        quantityLabel.text = "\(quantity)"
    }
    
    
    @IBAction func finishEditing(_ sender: Any) {
        delegate?.sendData(itemName: textField.text ?? "", number: quantity)
        print("Ok")
        self.dismiss(animated: true)
    }
}
