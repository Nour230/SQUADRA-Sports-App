//
//  LeagueDetailsPresenter.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import Foundation

class LeagueDetailsPresenter{
    var sportName: String
    var leagueID :Int
    var leaguesDetailsCollectionView: LeagueDetailsProtocol
    
    init(sportName: String, leagueID: Int, leaguesDetailsCollectionView: LeagueDetailsProtocol) {
        self.sportName = sportName
        self.leagueID = leagueID
        self.leaguesDetailsCollectionView = leaguesDetailsCollectionView
    }
    
    
    func getLeagueDetailsFromNetwork() {
        NetworkService.getLeagueDetails(sportName: sportName, leagueID: leagueID ) { res in
            self.leaguesDetailsCollectionView.displayLeagueDetails(res: res)
        }
    }
}
