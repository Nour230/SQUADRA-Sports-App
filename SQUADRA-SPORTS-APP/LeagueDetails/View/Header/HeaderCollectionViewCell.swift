//
//  HeaderCollectionViewCell.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 01/06/2025.
//

import UIKit

protocol HeaderCollectionViewCellDelegate: AnyObject {
    func presentRemoveFromFavoritesAlert(completion: @escaping () -> Void)
}

class HeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headerLeagueImageView: UIImageView!
    @IBOutlet weak var headerLeagueNameLabel: UILabel!
    @IBOutlet weak var headerLeagueCountryLabel: UILabel!
    @IBOutlet weak var headerLeagueSeasonLabel: UILabel!
    @IBOutlet weak var headerCountryImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var leagueDetailsPresenter: LeagueDetailsPresenter!
    
    var isFavorite: Bool!
    
    weak var delegate: HeaderCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addToFavourites(_ sender: Any) {
        if isFavorite {
            delegate?.presentRemoveFromFavoritesAlert {
                self.isFavorite = false
                self.updateFavButton()
                self.leagueDetailsPresenter.deleteFromDatabase()
            }
        } else {
            isFavorite = true
            updateFavButton()
            leagueDetailsPresenter.insertIntoDatabase()
        }
    }
    
    func updateFavButton() {
        let imageName = isFavorite! ? "heart.fill" : "heart"
        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
