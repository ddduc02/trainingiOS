//
//  RealtimeDatabaseViewController.swift
//  trainingiOS
//
//  Created by DucDo on 04/01/2024.
//

import UIKit
import FirebaseDatabase

class RealtimeDatabaseViewController: UIViewController  {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var ref = Database.database().reference()
    
    var message1 : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        let chatRef = self.ref.child("chat").child("user1")
        
        chatRef.observeSingleEvent(of: .value) { [weak self] (snapshot) in
                guard snapshot.exists() else {
                    print("Không có dữ liệu")
                    return
                }
                var messages: [String] = []
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let messageValue = childSnapshot.childSnapshot(forPath: "message").value as? String {
                        messages.append(messageValue)
                    }
                }
                
                self?.message1 = messages
                self?.tableView.reloadData()
            }
        // lắng nghe khi có child ở thêm ở node này
        chatRef.observe(.childAdded) { [self] (snapshot) in
            guard snapshot.exists() else {
                print("Không có dữ liệu")
                return
            }
            if let snapshot2 = snapshot.childSnapshot(forPath: "message").value as? String {
                message1.append(snapshot2)
                tableView.reloadData()
                if !message1.isEmpty {
                    let indexPath = IndexPath(row: message1.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
            
        }
    }
    
    @IBAction func send(_ sender: UIButton) {
        self.ref.child("chat").child("user1").childByAutoId().setValue(["message": textField.text])
        textField.text = ""
    }
    
}

extension RealtimeDatabaseViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell?
        cell?.content?.text = "\(message1[indexPath.row])"
        return cell!
    }
}
