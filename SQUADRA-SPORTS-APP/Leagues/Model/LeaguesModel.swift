//
//  LeaguesModel.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 30/05/2025.
//

import Foundation

struct LeaguesResponse: Codable {
    let result: [LeagueModel]
}

struct LeagueModel: Codable {
    let leagueName: String
    let leagueLogo: String?
    let countryName: String?
    let countryLogo: String?
    
    enum CodingKeys: String,CodingKey {
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case countryName = "country_name"
        case countryLogo = "country_logo"
    }
}
