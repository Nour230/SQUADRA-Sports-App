//
//  CoachTableViewCell.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 02/06/2025.
//

import UIKit

class CoachTableViewCell: UITableViewCell {

    
    @IBOutlet weak var coachImageView: UIImageView!
    @IBOutlet weak var coachNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
