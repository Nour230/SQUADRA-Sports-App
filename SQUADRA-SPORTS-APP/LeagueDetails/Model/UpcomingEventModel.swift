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
    let leagueID :Int?
    let awayTeamKey: String?
    let awayTeamLogo: String?
    let awayTeamName: String?
    let homeTeamKey: String?
    let homeTeamLogo: String?
    let homeTeamName: String?
    let leagueSeason :String?
    let eventDate :String?
    let eventTime :String?
    
    enum CodingKeys: String,CodingKey {
        case awayTeamKey = "away_team_key"
        case awayTeamLogo = "away_team_logo"
        case awayTeamName = "event_away_team"
        case homeTeamKey = "home_team_key"
        case homeTeamLogo = "home_team_logo"
        case homeTeamName = "event_home_team"
        case leagueSeason = "league_season"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case countryName = "country_name"
        case countryLogo = "country_logo"
        case leagueID = "league_key"
    }
}






