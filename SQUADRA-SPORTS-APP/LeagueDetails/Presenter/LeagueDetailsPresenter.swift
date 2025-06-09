//
//  LeagueDetailsPresenter.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import Foundation

class LeagueDetailsPresenter{
    var sportName :String
    var leagueID :Int
    var headerLeague :LeagueModel
    var leaguesDetailsCollectionView :LeagueDetailsProtocol
    
    init(sportName: String, leagueID: Int, headerLeague: LeagueModel, leaguesDetailsCollectionView: LeagueDetailsProtocol) {
        self.sportName = sportName
        self.leagueID = leagueID
        self.headerLeague = headerLeague
        self.leaguesDetailsCollectionView = leaguesDetailsCollectionView
    }
    
    func sendSelectedHeaderLeague() {
        self.leaguesDetailsCollectionView.displayHeaderLeagueDetails(res: headerLeague)
    }
    
    func getUpcomingLeagueDetailsFromNetwork() {
        NetworkService.getUpcomingLeagueDetails(sportName: sportName, leagueID: leagueID) { res in
            self.leaguesDetailsCollectionView.displayUpcomingLeagueDetails(res: res)
        }
    }
    
    
    func getLatestResultsLeagueDetailsFromNetwork() {
        if(sportName == "tennis"){
            NetworkService.getTennisPlayerbyLeagueID(leagueId: leagueID){
                res in
                self.leaguesDetailsCollectionView.displatAllResentTennisEvents(res: res)
            }
            }else{
                NetworkService.getLatestResultsLeagueDetails(sportName: sportName, leagueID: leagueID) { res in
                    self.leaguesDetailsCollectionView.displayLatestResultsLeagueDetails(res: res)
                }
            }
    }
    
    func getAllTeamsFromNetwork() {
        if(sportName == "tennis"){
            NetworkService.getAllTennisPlayer(leagueId: leagueID){ res in
                self.leaguesDetailsCollectionView.displayAllTennisPlayers(res: res)
            }
        }else{
            NetworkService.getAllTeamsDetails(sportName: sportName, leagueID: leagueID) { res in
                self.leaguesDetailsCollectionView.displayAllTeams(res: res)
            }
        }
    }
    
    func deleteFromDatabase() {
        LocalDataScource.deleteLeagueFromDataBase(leagueID: leagueID)
    }
    
    func insertIntoDatabase() {
        LocalDataScource.insertLeagueToDataBase(league: headerLeague, sportName: sportName)
    }
    
    func getLeagueByID() -> Bool {
        return LocalDataScource.getLeagueByID(leagueID: leagueID)
    }
}
