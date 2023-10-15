//
//  PostCell.swift
//  WSCRUD
//
//  Created by Victor Peralta on 14/10/23.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet var titlePost: UILabel!
    
    @IBOutlet var bodyPost: UILabel!
    
    @IBOutlet var userIdPost: UILabel!
    
    @IBOutlet var IdPost: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
