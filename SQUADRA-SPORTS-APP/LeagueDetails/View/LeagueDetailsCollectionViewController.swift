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
    func displayAllTeams(res: AllTeamsResponse)
    func displayHeaderLeagueDetails(res : LeagueModel)
    func displayAllTennisPlayers(res : TennisPlayerResponse)
    func displatAllResentTennisEvents(res : TennisPlayerResponse)
}

private let reuseIdentifier = "Cell"
class LeagueDetailsCollectionViewController: UICollectionViewController ,LeagueDetailsProtocol{
   
    

    var leagueDetailsPresenter : LeagueDetailsPresenter!
    
    var headerLeagueDetails : LeagueModel!
    var upcomingEvents : [UpcomingEventModel] = []
    var latestEvents : [LatestResultsEventModel] = []
    
    var allTeams : [TeamModel] = []
    var allResentTennisEvents : [TennisPlayerModel] = []
    var allTennisPlayers : [TennisPlayerModel] = []
    
    var headerLeagueSeason : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let nib = UINib(nibName:"EventCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier:"UpcomingEvents")
        
        let nib2 = UINib(nibName:"EventCollectionViewCell", bundle: nil)
        self.collectionView.register(nib2, forCellWithReuseIdentifier:"LatestResultsEvents")
        
        let nib3 = UINib(nibName:"TeamCollectionViewCell", bundle: nil)
        self.collectionView.register(nib3, forCellWithReuseIdentifier:"Teams")
        
        let nib4 = UINib(nibName:"HeaderCollectionViewCell", bundle: nil)
        self.collectionView.register(nib4, forCellWithReuseIdentifier:"Header")
        
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.reuseIdentifier)

        
        // Do any additional setup after loading the view.
        leagueDetailsPresenter.sendSelectedHeaderLeague()
        leagueDetailsPresenter.getUpcomingLeagueDetailsFromNetwork()
        leagueDetailsPresenter.getLatestResultsLeagueDetailsFromNetwork()
        leagueDetailsPresenter.getAllTeamsFromNetwork()
        
    }
    
    func displatAllResentTennisEvents(res: TennisPlayerResponse) {
        DispatchQueue.main.async {
            self.allResentTennisEvents = Array(res.result.dropFirst(30).prefix(30))
            self.collectionView.reloadData()
        }
    }
    
    
    func displayAllTennisPlayers(res: TennisPlayerResponse) {
        DispatchQueue.main.async {
            self.allTennisPlayers = Array(res.result.dropFirst(30).prefix(30))
            self.collectionView.reloadData()
        }
    }
    
    func displayHeaderLeagueDetails(res: LeagueModel) {
        DispatchQueue.main.async {
            self.headerLeagueDetails = res
            self.navigationItem.title = self.headerLeagueDetails.leagueName
            self.collectionView.reloadData()
        }
    }

    func displayUpcomingLeagueDetails(res : UpcomingEventResponse) {
        DispatchQueue.main.async {
            self.upcomingEvents = res.result
            self.collectionView.reloadData()
        }
    }
    
    func displayLatestResultsLeagueDetails(res: LatestResultsEventResponse) {
        DispatchQueue.main.async {

            self.latestEvents = Array(res.result.prefix(10))
            self.headerLeagueSeason = res.result.first?.leagueSeason
            self.collectionView.reloadData()
        }
    }

    
    func displayAllTeams(res: AllTeamsResponse) {
        DispatchQueue.main.async {
            self.allTeams = res.result
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
    
    func addHeader(to section: NSCollectionLayoutSection, height: CGFloat = 44) {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(height))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
    }

    func headerLeagueSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(420), heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0)
        section.interGroupSpacing = 10
        return section
    }
    
    func upcomingEventsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(350), heightDimension: .absolute(175))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 10, trailing: 16)
        section.interGroupSpacing = 10
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        addHeader(to: section)
        return section
    }
    
    func latestResultsEventsSection()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(375), heightDimension: .absolute(175))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 14, bottom: 10, trailing: 16)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 14, bottom: 16, trailing: 16)
        section.interGroupSpacing = 10
        addHeader(to: section)
        return section
    }
    
    func teamsSection()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0)
        section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        addHeader(to: section)
        return section
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            if self.leagueDetailsPresenter.sportName == "tennis" {
                switch sectionIndex {
                case 0:
                    return self.headerLeagueSection()
                case 1:
                    return self.latestResultsEventsSection() // For recent tennis events
                case 2:
                    return self.teamsSection() // For tennis players (reusing teams layout)
                default:
                    return nil
                }
            } else {
                switch sectionIndex {
                case 0:
                    return self.headerLeagueSection()
                case 1:
                    return self.upcomingEventsSection()
                case 2:
                    return self.latestResultsEventsSection()
                case 3:
                    return self.teamsSection()
                default:
                    return nil
                }
            }
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return leagueDetailsPresenter.sportName == "tennis" ? 3 : 4
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return headerLeagueDetails == nil ? 0 : 1
        case 1:
            if leagueDetailsPresenter.sportName == "tennis" {
                return allResentTennisEvents.count
            } else {
                return upcomingEvents.count
            }
        case 2:
            if leagueDetailsPresenter.sportName == "tennis" {
                return allTennisPlayers.count
            } else {
                return latestEvents.count
            }
        case 3:
            return allTeams.count
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Header", for: indexPath) as? HeaderCollectionViewCell else {
                fatalError("Could not dequeue cell")
            }
            let headerLeagueDetails = headerLeagueDetails!
            
            if let headerLeagueLogo = headerLeagueDetails.leagueLogo,
               let url = URL(string: headerLeagueLogo) {
                cell.headerLeagueImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownLeague"))
            } else {
                cell.headerLeagueImageView.image = UIImage(named: "UnkownLeague")
            }
            cell.headerLeagueNameLabel.text = headerLeagueDetails.leagueName
            cell.headerLeagueCountryLabel.text = headerLeagueDetails.countryName ?? "Unkown Country"
            cell.headerLeagueSeasonLabel.text = headerLeagueSeason ?? "N/A"
            if let headerLeagueCountryLogo = headerLeagueDetails.countryLogo,
               let url = URL(string: headerLeagueCountryLogo) {
                cell.headerCountryImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownFlag"))
            } else {
                cell.headerCountryImageView.image = UIImage(named: "UnkownFlag")
            }
            
            return cell
            
        case 1:
            if leagueDetailsPresenter.sportName == "tennis" {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestResultsEvents", for: indexPath) as? EventCollectionViewCell else {
                    fatalError("Could not dequeue cell")
                }
                let tennisEvent = allResentTennisEvents[indexPath.item]
                
                if let firstPlayerLogo = tennisEvent.eventFirstPlayerLogo,
                   let url = URL(string: firstPlayerLogo) {
                    cell.homeTeamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownPlayer"))
                } else {
                    cell.homeTeamImageView.image = UIImage(named: "UnkownPlayer")
                }
                cell.homeTeamLabel.text = tennisEvent.eventFirstPlayer ?? "Unknown Player"
                
                if let secondPlayerLogo = tennisEvent.eventScoundPlayerLogo,
                   let url = URL(string: secondPlayerLogo) {
                    cell.awayTeamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownPlayer"))
                } else {
                    cell.awayTeamImageView.image = UIImage(named: "UnkownPlayer")
                }
                cell.awayTeamLabel.text = tennisEvent.eventSecondPlayer ?? "Unknown Player"
                
                cell.timeOrScoreLabel.text = tennisEvent.eventFinalResult ?? "-"
                cell.dateLabel.text = tennisEvent.eventDate ?? "Unknown Date"
                
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEvents", for: indexPath) as? EventCollectionViewCell else {
                    fatalError("Could not dequeue cell")
                }
                let event = upcomingEvents[indexPath.item]
                
                if let homeTeamLogo = event.homeTeamLogo,
                   let url = URL(string: homeTeamLogo) {
                    cell.homeTeamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownTeam"))
                } else {
                    cell.homeTeamImageView.image = UIImage(named: "UnkownTeam")
                }
                cell.homeTeamLabel.text = event.eventHomeTeam ?? "Unkown Team"
                
                if let awayTeamLogo = event.awayTeamLogo,
                   let url = URL(string: awayTeamLogo) {
                    cell.awayTeamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownTeam"))
                } else {
                    cell.awayTeamImageView.image = UIImage(named: "UnkownTeam")
                }
                cell.awayTeamLabel.text = event.eventAwayTeam ?? "Unkown Team"
                
                cell.timeOrScoreLabel.text = event.eventTime ?? "Unkown Time"
                cell.dateLabel.text = event.eventDate ?? "Unkown Date"
                
                return cell
            }
            
        case 2:
            if leagueDetailsPresenter.sportName == "tennis" {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Teams", for: indexPath) as? TeamCollectionViewCell else {
                    fatalError("Could not dequeue cell")
                }
                let player = allTennisPlayers[indexPath.item]
                
                if let playerImage = player.eventFirstPlayerLogo,
                   let url = URL(string: playerImage) {
                    cell.teamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownPlayer"))
                } else {
                    cell.teamImageView.image = UIImage(named: "UnkownPlayer")
                }
                cell.teamNameLable.text = player.eventFirstPlayer ?? "Unknown Player"
                
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestResultsEvents", for: indexPath) as? EventCollectionViewCell else {
                    fatalError("Could not dequeue cell")
                }
                let event = latestEvents[indexPath.item]
                
                if let homeTeamLogo = event.homeTeamLogo,
                   let url = URL(string: homeTeamLogo) {
                    cell.homeTeamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownTeam"))
                } else {
                    cell.homeTeamImageView.image = UIImage(named: "UnkownTeam")
                }
                cell.homeTeamLabel.text = event.homeTeamName ?? "Unkown Team"
                
                if let awayTeamLogo = event.awayTeamLogo,
                   let url = URL(string: awayTeamLogo) {
                    cell.awayTeamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownTeam"))
                } else {
                    cell.awayTeamImageView.image = UIImage(named: "UnkownTeam")
                }
                cell.awayTeamLabel.text = event.awayTeamName ?? "Unkown Team"
                
                cell.timeOrScoreLabel.text = event.result ?? "-"
                cell.dateLabel.text = event.eventDate ?? "Unkown Date"
                
                return cell
            }
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Teams", for: indexPath) as? TeamCollectionViewCell else {
                fatalError("Could not dequeue cell")
            }
            let team = allTeams[indexPath.item]
            
            if let teamLogo = team.teamLogo,
               let url = URL(string: teamLogo) {
                cell.teamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownTeam"))
            } else {
                cell.teamImageView.image = UIImage(named: "UnkownTeam")
            }
            cell.teamNameLable.text = team.teamName ?? "Unkown Team"
            
            return cell
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier,
            for: indexPath) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        
        switch indexPath.section {
            case 1:
                header.titleLabel.text = leagueDetailsPresenter.sportName == "tennis" ? "Recent Tennis Events" : "Upcoming Events"
            case 2:
                header.titleLabel.text = leagueDetailsPresenter.sportName == "tennis" ? "Tennis Players" : "Latest Results"
            case 3:
                header.titleLabel.text = "League Teams"
            default:
                header.titleLabel.text = ""
            }
            
            return header
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamDetailsStoryboard = UIStoryboard(name: "TeamDetails", bundle: nil)
        if let teamDetailsTableVC = teamDetailsStoryboard.instantiateViewController(withIdentifier: "TeamDetails") as? TeamDetailsViewController {
            switch(indexPath.section){
            case 3 :
                let selectedTeam = self.allTeams[indexPath.row]
                let sportName = self.leagueDetailsPresenter.sportName
                    
                    let teamDetailsPresenter = TeamDetailsPresenter(selectedTeam: selectedTeam, sportName: sportName, teamDetailsTableView: teamDetailsTableVC)
                    teamDetailsTableVC.teamDetailsPresenter = teamDetailsPresenter
                self.navigationController?.pushViewController(teamDetailsTableVC, animated: true)
                
            default :
                return
            }
            
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
