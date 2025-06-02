//
//  TeamDetailsViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 01/06/2025.
//

import UIKit

protocol TeamDetailsProtocol {
    func displayTeamDetails(res: TeamModel)
}

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TeamDetailsProtocol{

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamDetailsTableView: UITableView!
    
    var teamDetailsPresenter : TeamDetailsPresenter!
    
    var team : TeamModel!
    
    var coachesArray : [Coach] = []
    var playersArray : [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        teamDetailsTableView.delegate = self
        teamDetailsTableView.dataSource = self

        let nib = UINib(nibName: "PlayerTableViewCell", bundle: nil)
        teamDetailsTableView.register(nib, forCellReuseIdentifier: "PlayerCell")
        
        let nib2 = UINib(nibName: "CoachTableViewCell", bundle: nil)
      //  teamDetailsTableView.register(nib2, forCellReuseIdentifier: "")
        
        teamDetailsPresenter.getTeamDetails()
    }
    
    func displayTeamDetails(res: TeamModel) {
        DispatchQueue.main.async {
            self.team = res
            self.navigationItem.title = "\(self.team.teamName!) Team Details"
            self.teamNameLabel.text = self.team.teamName!
            self.teamImageView.kf.setImage(with: URL(string: self.team.teamLogo!))
            if let coachesArray = self.team.coaches {
                self.coachesArray = coachesArray
            }else{
                self.coachesArray = []
            }
            
            if let playersArray = self.team.players {
                self.playersArray = playersArray
            }else{
                self.playersArray = []
            }
            self.teamDetailsTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return coachesArray.count
        case 1:
            return playersArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            // Configure the cell
        case 0:
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as? CoachTableViewCell
            else {
                fatalError("Could not dequeue cell")
            }
            let coach = coachesArray[indexPath.row]
            
            cell.coachImageView.image = UIImage(named: "UnkownCoach")
            if let coachName = coach.coachName {
                cell.coachNameLabel.text = coachName
            } else {
                cell.coachNameLabel.text = "Unkown Coach"
            }
            
            return cell
            
        case 1:
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell
            else {
                fatalError("Could not dequeue cell")
            }
            let player = playersArray[indexPath.row]
            
            if let playerLogo = player.playerImage,
                let url = URL(string: playerLogo) {
                    cell.playerImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownPlayer"))
                } else {
                    cell.playerImageView.image = UIImage(named: "UnkownPlayer")
                }
            if let playerName = player.playerName {
                cell.playerNameLabel.text = playerName
            } else {
                cell.playerNameLabel.text = "Unkown Player"
            }
            if let playerAge = player.playerAge {
                cell.playerAgeLabel.text = playerAge
            } else {
                cell.playerAgeLabel.text = "Unkown Age"
            }
            if let playerPosition = player.playerType {
                cell.playerPositionLabel.text = playerPosition
            } else {
                cell.playerPositionLabel.text = "Unkown Position"
            }
            if let playerNumber = player.playerNumber {
                cell.playerNumberLabel.text = playerNumber
            } else {
                cell.playerNumberLabel.text = "Unkown Number"
            }
            
            return cell
            
        default:
            guard let cell = teamDetailsTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell
            else {
                fatalError("Could not dequeue cell")
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Coaches"
        case 1:
            return "Players"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.teamDetailsTableView.bounds.size.width, height: 40))
        let label = UILabel(frame: CGRect(x: 5, y: -10, width: (self.teamDetailsTableView.bounds.size.width ) - 32, height: 30))
        label.textColor = UIColor.black
        label.font = UIFont(name: "System", size: 18)
        
        switch section{
        case 0:
            label.text = "Coach"
            break
        default:
            label.text = "Players"
            break
        }
        
        header.addSubview(label)
        return header
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
