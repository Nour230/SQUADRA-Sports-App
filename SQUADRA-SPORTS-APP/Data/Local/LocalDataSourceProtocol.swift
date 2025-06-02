//
//  LocalDataSourceProtocol.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 02/06/2025.
//

import Foundation

protocol LocalDataSourceProtocol{
    func insertLeagueToDataBase(league: LeagueModel)
    
    func getAllLeaguesFromDataBase()
    
    func deleteLeagueFromDataBase(leagueid : Int)
    
    func getLeagueByID(leagueID :Int) -> Bool
}
