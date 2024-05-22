//
//  GrammarTableViewCell.swift
//  AppTiengAnh
//
//  Created by Nguyen Thi Tham on 16/5/24.
//

import UIKit

class GrammarTableViewCell: UITableViewCell {

    @IBOutlet weak var img_NP: UIImageView!
    
    @IBOutlet weak var lbl_NP: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
