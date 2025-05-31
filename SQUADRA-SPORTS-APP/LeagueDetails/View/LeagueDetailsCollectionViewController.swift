//
//  LeagueDetailsCollectionViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import UIKit

protocol LeagueDetailsProtocol{
    func displayUpcomingLeagueDetails(res : UpcomingEventResponse)
    func displayLatestResultsLeagueDetails(res : LatestResultsEventResponse)
}

private let reuseIdentifier = "Cell"
class LeagueDetailsCollectionViewController: UICollectionViewController ,LeagueDetailsProtocol{

    var leagueDetailsPresenter : LeagueDetailsPresenter!
    
    var upcomingEvents : [UpcomingEventModel] = []
    var latestEvents : [LatestResultsEventModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.title = "League Details"
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let nib = UINib(nibName:"EventCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier:"UpcomingEvents")
        
        let nib2 = UINib(nibName:"EventCollectionViewCell", bundle: nil)
        self.collectionView.register(nib2, forCellWithReuseIdentifier:"LatestResultsEvents")
        
        let nib3 = UINib(nibName:"TeamCollectionViewCell", bundle: nil)
        self.collectionView.register(nib3, forCellWithReuseIdentifier:"Teams")
        
        // Do any additional setup after loading the view.
        leagueDetailsPresenter.getUpcomingLeagueDetailsFromNetwork()
        leagueDetailsPresenter.getLatestResultsLeagueDetailsFromNetwork()
    }

    func displayUpcomingLeagueDetails(res : UpcomingEventResponse) {
        DispatchQueue.main.async {
            self.upcomingEvents = res.result
            self.collectionView.reloadData()
        }
    }
    
    func displayLatestResultsLeagueDetails(res: LatestResultsEventResponse) {
        DispatchQueue.main.async {
            self.latestEvents = res.result
            self.collectionView.reloadData()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func upcomingEventsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(350), heightDimension: .absolute(175))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 150, leading: 16, bottom: 10, trailing: 16)
        section.interGroupSpacing = 10
        return section
    }
    
    func latestResultsEventsSection()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(375), heightDimension: .absolute(175))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 14, bottom: 10, trailing: 16)
        section.interGroupSpacing = 10
        return section
    }
    
    func teamsSection()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func createLayout()-> UICollectionViewLayout{
        return UICollectionViewCompositionalLayout{ sectionIndex , _ in
            switch sectionIndex{
            case 0 :
                return self.upcomingEventsSection()
            case 1 :
                return self.latestResultsEventsSection()
            default :
                return self.teamsSection()
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return upcomingEvents.count
        case 1:
            return latestEvents.count
        case 2:
            return 5
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        // Configure the cell
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEvents", for: indexPath) as? EventCollectionViewCell else {
                fatalError("Could not dequeue cell")
            }
            let event = upcomingEvents[indexPath.item]
            
            if let homeTeamLogo = event.homeTeamLogo,
               let url = URL(string: homeTeamLogo) {
                cell.homeTeamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownLeague"))
            } else {
                cell.homeTeamImageView.image = UIImage(named: "UnkownLeague")
            }
            if let homeTeamName = event.eventHomeTeam {
                cell.homeTeamLabel.text = homeTeamName
            } else {
                cell.homeTeamLabel.text = "Unkown Team"
            }
            
            if let awayTeamLogo = event.awayTeamLogo,
               let url = URL(string: awayTeamLogo) {
                cell.awayTeamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownLeague"))
            } else {
                cell.awayTeamImageView.image = UIImage(named: "UnkownLeague")
            }
            if let awayTeamName = event.eventAwayTeam {
                cell.awayTeamLabel.text = awayTeamName
            } else {
                cell.awayTeamLabel.text = "Unkown Team"
            }
            
            if let eventTime = event.eventTime {
                cell.timeOrScoreLabel.text = eventTime
            } else {
                cell.timeOrScoreLabel.text = "Unkown Time"
            }
            if let eventDate = event.eventDate {
                cell.dateLabel.text = eventDate
            } else {
                cell.dateLabel.text = "Unkown Date"
            }
            
            return cell
            
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestResultsEvents", for: indexPath) as? EventCollectionViewCell else {
                fatalError("Could not dequeue cell")
            }
            let event = latestEvents[indexPath.item]
            
            if let homeTeamLogo = event.homeTeamLogo,
               let url = URL(string: homeTeamLogo) {
                cell.homeTeamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownLeague"))
            } else {
                cell.homeTeamImageView.image = UIImage(named: "UnkownLeague")
            }
            if let homeTeamName = event.homeTeamName {
                cell.homeTeamLabel.text = homeTeamName
            } else {
                cell.homeTeamLabel.text = "Unkown Team"
            }
            
            if let awayTeamLogo = event.awayTeamLogo,
               let url = URL(string: awayTeamLogo) {
                cell.awayTeamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownLeague"))
            } else {
                cell.awayTeamImageView.image = UIImage(named: "UnkownLeague")
            }
            if let awayTeamName = event.awayTeamName {
                cell.awayTeamLabel.text = awayTeamName
            } else {
                cell.awayTeamLabel.text = "Unkown Team"
            }
            
            if let eventScore = event.result {
                cell.timeOrScoreLabel.text = eventScore
            } else {
                cell.timeOrScoreLabel.text = "-"
            }
            if let eventDate = event.eventDate {
                cell.dateLabel.text = eventDate
            } else {
                cell.dateLabel.text = "Unkown Date"
            }
            
            return cell
            
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEvents", for: indexPath) as? EventCollectionViewCell
            return cell!
        }
    
    
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
