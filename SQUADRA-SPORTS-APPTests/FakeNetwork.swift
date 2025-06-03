//
//  FakeNetwork.swift
//  SQUADRA-SPORTS-APPTests
//
//  Created by nourhan essam on 04/06/2025.
//

import Foundation
@testable import SQUADRA_SPORTS_APP

class FakeNetwork{
    var shouldReturnError : Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
}

extension FakeNetwork{
    func getLeagues(sport: String, handler: @escaping ([LeagueModel])->Void) {
        var leagues : [LeagueModel] = []
        if shouldReturnError {
            handler(leagues)
        }else{
            leagues = [LeagueModel(leagueName: "league", leagueLogo: "", leagueID: 4),
                       LeagueModel(leagueName: "league", leagueLogo: "", leagueID: 9)]
            handler(leagues)
        }
    }
}
