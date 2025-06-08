//
//  TeamCollectionViewCell.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamNameLable: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
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
            teamNameLable.textColor = UIColor.white
            
        } else {
            teamNameLable.textColor = UIColor.black
            
        }
    }
}
