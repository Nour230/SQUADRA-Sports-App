//
//  EventCollectionViewCell.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    @IBOutlet weak var timeOrScoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
