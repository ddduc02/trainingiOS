//
//  TableViewCell.swift
//  trainingiOS
//
//  Created by DucDo on 04/01/2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
