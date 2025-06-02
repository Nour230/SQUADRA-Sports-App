//
//  LeaguesPresenter.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import Foundation

class LeaguesPresenter {
    var sportName: String
    var leaguesTableView: LeaguesProtocol
    
    init(leaguesTableView: LeaguesProtocol, sportName: String) {
        self.leaguesTableView = leaguesTableView
        self.sportName = sportName
    }

    func getLeagueFromNetwork() {
        NetworkService.getLeagues(sportName: sportName) { res in
            self.leaguesTableView.renderLeaguesTableView(result: res)
        }
    }

}
