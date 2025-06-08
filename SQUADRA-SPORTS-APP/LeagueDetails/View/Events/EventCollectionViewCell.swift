//
//  EventCollectionViewCell.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    @IBOutlet weak var timeOrScoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateAppearance()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateAppearance()
        }
    }

    private func updateAppearance() {
        if traitCollection.userInterfaceStyle == .dark {
            self.backgroundColor = UIColor.white
            homeTeamLabel.textColor = UIColor.black
            awayTeamLabel.textColor = UIColor.black
            timeOrScoreLabel.textColor = UIColor.black
            dateLabel.textColor = UIColor.black
            leagueNameLabel.textColor = UIColor.black
            
        } else {
            self.backgroundColor = UIColor.black
            homeTeamLabel.textColor = UIColor.white
            awayTeamLabel.textColor = UIColor.white
            timeOrScoreLabel.textColor = UIColor.white
            dateLabel.textColor = UIColor.white
            leagueNameLabel.textColor = UIColor.white
        }
    }
}
