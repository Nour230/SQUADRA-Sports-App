//
//  LeaguesTableViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 30/05/2025.
//

import UIKit
import Kingfisher
import Alamofire


class LeaguesTableViewController: UITableViewController , LeaguesProtocol {
        
    var leaguesArray : [LeagueModel] = []
    var leaguesPresenter : LeaguesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Leagues"

        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LeaguesCell")
        
        //leaguesPresenter = LeaguesPresenter(leaguesTableView: self)
        leaguesPresenter.getLeagueFromNetwork()
        self.tableView.reloadData()
    }
    
    func renderLeaguesTableView(result: LeaguesResponse) {
        DispatchQueue.main.async {
            self.leaguesArray = result.result
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesCell", for: indexPath) as! LeaguesTableViewCell

        // Configure the cell...
        if let leagueLogo = leaguesArray[indexPath.row].leagueLogo,
           let url = URL(string: leagueLogo) {
            cell.leagueImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownLeague"))
        } else {
            cell.leagueImageView.image = UIImage(named: "UnkownLeague")
        }

        cell.leagueNameLabel.text = leaguesArray[indexPath.row].leagueName
        if let countryLogo = leaguesArray[indexPath.row].countryLogo,
           let url = URL(string: countryLogo) {
            cell.leagueCountryImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownFlag"))
        } else {
            cell.leagueCountryImageView.image = UIImage(named: "UnkownFlag")
        }
        
        if let countryName = leaguesArray[indexPath.row].countryName {
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
        let leagueDetailsStoryboard = UIStoryboard(name: "LeaguesDetails", bundle: nil)
        if let leagueDetailsCollectionVC = leagueDetailsStoryboard.instantiateViewController(withIdentifier: "") as? LeagueDetailsCollectionViewController {
            
            let name = leaguesPresenter.sportName
            guard let leagueID = leaguesArray[indexPath.row].leagueID else { return }
            
            let leagueDetailsPresenter = LeagueDetailsPresenter(sportName: name, leagueID: leagueID, leaguesDetailsCollectionView: leagueDetailsCollectionVC)
            leagueDetailsCollectionVC.leagueDetailsPresenter = leagueDetailsPresenter
            navigationController?.pushViewController(leagueDetailsCollectionVC, animated: true)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
