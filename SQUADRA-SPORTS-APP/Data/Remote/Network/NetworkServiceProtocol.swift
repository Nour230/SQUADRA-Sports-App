//
//  NetworkServiceProtocol.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 03/06/2025.
//

import Foundation

protocol NetworkServiceProtocol{
    static func getLeagues(sportName: String, handler: @escaping (LeaguesResponse)->Void)
    static func getUpcomingLeagueDetails(sportName: String,leagueID:Int, handler: @escaping (UpcomingEventResponse)->Void)
    static func getLatestResultsLeagueDetails(sportName: String,leagueID: Int, handler: @escaping (LatestResultsEventResponse)->Void)
    static func getAllTeamsDetails(sportName: String,leagueID: Int, handler: @escaping (AllTeamsResponse)->Void)
    static func getTennisPlayerbyLeagueID(leagueId: Int, handler: @escaping (TennisPlayerResponse)->Void)
    static func getAllTennisPlayer( handler: @escaping (TennisPlayerResponse)->Void)
}
