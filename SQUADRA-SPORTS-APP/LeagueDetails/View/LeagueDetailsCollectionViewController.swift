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
}

private let reuseIdentifier = "Cell"
class LeagueDetailsCollectionViewController: UICollectionViewController ,LeagueDetailsProtocol{

    var leagueDetailsPresenter : LeagueDetailsPresenter!
    
    var headerLeagueDetails : LeagueModel!
    var upcomingEvents : [UpcomingEventModel] = []
    var latestEvents : [LatestResultsEventModel] = []
    
    var allTeams : [TeamModel] = []
    
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
        section.orthogonalScrollingBehavior = .continuous
        addHeader(to: section)
        return section
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
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


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return headerLeagueDetails == nil ? 0 : 1
        case 1:
            return upcomingEvents.count
        case 2:
            return latestEvents.count
        case 3:
            return allTeams.count
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        // Configure the cell
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
            if let headerLeagueCountryName = headerLeagueDetails.countryName {
                cell.headerLeagueCountryLabel.text = headerLeagueCountryName
            } else {
                cell.headerLeagueCountryLabel.text = "Unkown Country"
            }
            cell.headerLeagueSeasonLabel.text = headerLeagueSeason ?? "N/A"
            if let headerLeagueCountryLogo = headerLeagueDetails.countryLogo,
               let url = URL(string: headerLeagueCountryLogo) {
                cell.headerCountryImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownFlag"))
            } else {
                cell.headerCountryImageView.image = UIImage(named: "UnkownFlag")
            }
            
            return cell
            
        case 1:
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
            
        case 2:
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Teams", for: indexPath) as? TeamCollectionViewCell
            let team = allTeams[indexPath.item]
            
            if let teamLogo = team.teamLogo,
               let url = URL(string: teamLogo) {
                cell?.teamImageView.kf.setImage(with: url, placeholder: UIImage(named: "UnkownLeague"))
            } else {
                cell?.teamImageView.image = UIImage(named: "UnkownLeague")
            }
            if let teamName = team.teamName {
                cell?.teamNameLable.text = teamName
            } else {
                cell?.teamNameLable.text = "Unkown Team"
            }
            return cell!
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
            header.titleLabel.text = "Upcoming Events"
        case 2:
            header.titleLabel.text = "Latest Results Events"
        case 3:
            header.titleLabel.text = "Teams"
        default:
            header.titleLabel.text = ""
        }
        
        return header
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
