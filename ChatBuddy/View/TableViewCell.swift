//
//  TableViewCell.swift
//  ChatBuddy
//
//  Created by Nagashree,Nagashree on 06/11/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var youImage: UIImageView!
    @IBOutlet weak var meImage: UIImageView!
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib() {
        // Initialization code
        super.awakeFromNib()
        messageBubble.layer.cornerRadius=messageBubble.frame.height/5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
