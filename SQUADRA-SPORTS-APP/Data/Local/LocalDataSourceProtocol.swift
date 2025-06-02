//
//  LocalDataSourceProtocol.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 02/06/2025.
//

import Foundation

protocol LocalDataSourceProtocol{
    static func insertLeagueToDataBase(league: LeagueModel, sportName:String)
    
    static func getAllLeaguesFromDataBase() -> [CachedFavouritesModel]
    
    static func deleteLeagueFromDataBase(leagueID : Int)
    
    static func getLeagueByID(leagueID :Int) -> Bool
}
