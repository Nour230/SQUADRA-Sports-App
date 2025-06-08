//
//  PlayerTableViewCell.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 01/06/2025.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerAgeLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerAgeIcon: UIImageView!
    @IBOutlet weak var playerPositionIcon: UIImageView!
    @IBOutlet weak var playerNumberIcon: UIImageView!
    @IBOutlet weak var playerNumberLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
