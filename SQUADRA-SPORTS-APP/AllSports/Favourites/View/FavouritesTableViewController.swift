//
//  FavouritesTableViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 02/06/2025.
//

import UIKit

protocol FavouritesProtocol{
    func displayAllFavouritesLeagues(result : [CachedFavouritesModel])
}

class FavouritesTableViewController: UITableViewController , FavouritesProtocol {
    
    var favouritesPresenter : FavouritesPresenter!
    
    var favouritesLeagues : [CachedFavouritesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouritesPresenter = FavouritesPresenter(favouritesTableVC: self)
        
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FavouritesCell")
        updateSeparatorColor()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        favouritesPresenter.getAllFavouritesFromDataBase()
        tableView.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            updateSeparatorColor()
        }
    }

    func updateSeparatorColor() {
        if traitCollection.userInterfaceStyle == .dark {
            tableView.separatorColor = UIColor.lightGray.withAlphaComponent(0.9)
        } else {
            tableView.separatorColor = UIColor.white
        }
    }
    
    func displayAllFavouritesLeagues(result : [CachedFavouritesModel]) {
        DispatchQueue.main.async {
            self.favouritesLeagues = result
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favouritesLeagues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesCell", for: indexPath) as! LeaguesTableViewCell
        
        // Configure the cell...
        
        if let leagueLogo = favouritesLeagues[indexPath.row].leagueModel.leagueLogo,
           let url = URL(string: leagueLogo) {
            cell.leagueImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownLeague"))
        } else {
            cell.leagueImageView.image = UIImage(named: "UnkownLeague")
        }
        
        cell.leagueNameLabel.text = favouritesLeagues[indexPath.row].leagueModel.leagueName
        if let countryLogo = favouritesLeagues[indexPath.row].leagueModel.countryLogo,
           let url = URL(string: countryLogo) {
            cell.leagueCountryImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownFlag"))
        } else {
            cell.leagueCountryImageView.image = UIImage(named: "UnkownFlag")
        }
        
        if let countryName = favouritesLeagues[indexPath.row].leagueModel.countryName {
            cell.leagueCountryNameLabel.text = countryName
        } else {
            cell.leagueCountryNameLabel.text = "Unkown Country"
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsStoryboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
        if let leagueDetailsCollectionVC = leagueDetailsStoryboard.instantiateViewController(withIdentifier: "LeagueDetails") as? LeagueDetailsCollectionViewController {
            
            guard let name = favouritesLeagues[indexPath.row].sportName else{return}
            guard let leagueID = favouritesLeagues[indexPath.row].leagueModel.leagueID else { return }
            
            guard let headerLeague = favouritesLeagues[indexPath.row].leagueModel else { return }
            
            let leagueDetailsPresenter = LeagueDetailsPresenter(sportName: name, leagueID: leagueID, headerLeague: headerLeague, leaguesDetailsCollectionView: leagueDetailsCollectionVC)
            leagueDetailsCollectionVC.leagueDetailsPresenter = leagueDetailsPresenter
            
            NetworkManager.isInternetAvailable { isConnected in
                DispatchQueue.main.async {
                    if isConnected {
                        self.navigationController?.pushViewController(leagueDetailsCollectionVC, animated: true)
                    } else {
                        let alert = UIAlertController(
                            title: "No Internet Connection",
                            message: "Check Your Internet Connection!",
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
        
        
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        
        // Override to support editing the table view.
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
                let selectedLeague = favouritesLeagues[indexPath.row]
                
                let alert = UIAlertController(title: "Remove From Favorites",
                                              message: "Are You Sure Yow Want To Remove This League From Your Favourites ?",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { _ in
                    
                    self.favouritesLeagues.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    
                    self.favouritesPresenter.deleteFavouriteLeagueFromDataBase(ID: selectedLeague.leagueModel.leagueID!)
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
        

        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
