//
//  LeaguesTableViewCell.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 30/05/2025.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueCountryImageView: UIImageView!
    @IBOutlet weak var leagueCountryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
