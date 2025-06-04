//
//  CollectionViewCell.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 30/05/2025.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportsName: UILabel!
    @IBOutlet weak var sportsImageView: UIImageView!
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
              sportsName.textColor = UIColor.black
          } else {
              self.backgroundColor = UIColor.black
              sportsName.textColor = UIColor.white
          }
      }
  }
