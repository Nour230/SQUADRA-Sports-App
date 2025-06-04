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
                  backgroundColor = .white
                  leagueNameLabel.textColor = .black
                  leagueCountryNameLabel.textColor = .black
              } else {
                  backgroundColor = .black
                  leagueNameLabel.textColor = .white
                  leagueCountryNameLabel.textColor = .white
              }
          }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
