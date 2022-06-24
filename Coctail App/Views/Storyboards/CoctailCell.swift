//
//  CoctailCell.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 24.06.22.
//

import UIKit

class CoctailCell: UITableViewCell {

    
    @IBOutlet weak var coctailImage: UIImageView!
    @IBOutlet weak var coctailName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
