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
    @IBOutlet weak var headerLeagueCalenderIcon: UIImageView!
    
    var leagueDetailsPresenter: LeagueDetailsPresenter!
    
    var isFavorite: Bool!
    
    weak var delegate: HeaderCollectionViewCellDelegate?
    
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
            headerLeagueImageView.backgroundColor = UIColor.white
            headerLeagueNameLabel.textColor = UIColor.white
            headerLeagueCountryLabel.textColor = UIColor.white
            headerLeagueSeasonLabel.textColor = UIColor.white
            favouriteButton.tintColor = UIColor.white
            headerLeagueCalenderIcon.tintColor = .white
        } else {
            headerLeagueNameLabel.textColor = UIColor.black
            headerLeagueCountryLabel.textColor = UIColor.black
            headerLeagueSeasonLabel.textColor = UIColor.black
            favouriteButton.tintColor = UIColor.black
            headerLeagueCalenderIcon.tintColor = .black
        }
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
        if(imageName == "heart.fill"){
            favouriteButton.tintColor = .red
        } else {
            if traitCollection.userInterfaceStyle == .dark {
                favouriteButton.tintColor = .white
            }else{
                favouriteButton.tintColor = .black
            }
            
        }
    }
    
}
