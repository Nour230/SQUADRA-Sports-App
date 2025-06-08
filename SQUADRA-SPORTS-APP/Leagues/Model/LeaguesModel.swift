//
//  LeaguesModel.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import Foundation

struct LeaguesResponse: Codable {
    let result: [LeagueModel]
}
struct LeagueModel: Codable {
    var leagueName: String
    var leagueLogo: String?
    var countryName: String?
    var countryLogo: String?
    var leagueID: Int?

    enum CodingKeys: String, CodingKey {
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case countryName = "country_name"
        case countryLogo = "country_logo"
        case leagueID = "league_key"
    }
}
