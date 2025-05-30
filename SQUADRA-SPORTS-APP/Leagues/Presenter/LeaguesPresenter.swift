//
//  LeaguesPresenter.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 30/05/2025.
//

import Foundation

class LeaguesPresenter {
    var sportName: String
    var leaguesTableView: LeaguesProtocol
    
    init(leaguesTableView: LeaguesProtocol, sportName: String) {
        self.leaguesTableView = leaguesTableView
        self.sportName = sportName
    }

    func getDataFromModel() {
        NetworkService.getLeagues(sportName: sportName) { res in
            self.leaguesTableView.renderLeaguesTableView(result: res)
        }
    }
}
