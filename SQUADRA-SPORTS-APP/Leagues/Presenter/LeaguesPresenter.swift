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
       var leagues: [LeagueModel] = []

       init(leaguesTableView: LeaguesProtocol, sportName: String) {
           self.leaguesTableView = leaguesTableView
           self.sportName = sportName
       }

    func getLeagueFromNetwork() {
        NetworkService.getLeagues(sportName: sportName) { res in
            self.leagues = res.result
            self.leaguesTableView.renderLeaguesTableView(result: res)
        }
    }
    
    func insertIntoDatabase(league : LeagueModel) {
        LocalDataScource.insertLeagueToDataBase(league: league, sportName: sportName)
    }

    func isFavorited(leagueID: Int) -> Bool {
            return LocalDataScource.getLeagueByID(leagueID: leagueID)
        }

    func toggleFavorite(for index: Int) {
        guard index < leagues.count else { return }
        let league = leagues[index]
        guard let leagueID = league.leagueID else { return }

        if isFavorited(leagueID: leagueID) {
            // Deletion needs confirmation — notify view instead
            leaguesTableView.confirmDeletion(of: league, at: index)
        } else {
            LocalDataScource.insertLeagueToDataBase(league: league, sportName: sportName)
            leaguesTableView.reloadRow(at: index)
        }
    }

    func deleteFavorite(at index: Int) {
        guard index < leagues.count else { return }
        let leagueID = leagues[index].leagueID ?? 0
        LocalDataScource.deleteLeagueFromDataBase(leagueID: leagueID)
        leaguesTableView.reloadRow(at: index)
    }

}
