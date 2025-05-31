//
//  UpcomingEventModel.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import Foundation


struct UpcomingEventResponse: Codable {
    let result: [UpcomingEventModel]
}

struct UpcomingEventModel: Codable {
    let leagueName: String
    let leagueLogo: String?
    let countryName: String?
    let countryLogo: String?
    let leagueId :Int?
    let awayTeamKey: Int?
    let awayTeamLogo: String?
    let eventAwayTeam: String?
    let homeTeamKey: Int?
    let homeTeamLogo: String?
    let eventHomeTeam: String?
    let leagueSeason :String?
    let eventDate :String?
    let eventTime :String?
    
    enum CodingKeys: String,CodingKey {
        case awayTeamKey = "away_team_key"
        case awayTeamLogo = "away_team_logo"
        case eventAwayTeam = "event_away_team"
        case homeTeamKey = "home_team_key"
        case homeTeamLogo = "home_team_logo"
        case eventHomeTeam = "event_home_team"
        case leagueSeason = "league_season"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case countryName = "country_name"
        case countryLogo = "country_logo"
        case leagueId = "league_key"
    }
}






