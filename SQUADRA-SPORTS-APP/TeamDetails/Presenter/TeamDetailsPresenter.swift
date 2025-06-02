//
//  TeamDetailsPresenter.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 01/06/2025.
//

import Foundation

class TeamDetailsPresenter {
    var selectedTeam :TeamModel
    var sportName :String
    var teamDetailsTableView :TeamDetailsProtocol
    
    init(selectedTeam: TeamModel, sportName: String, teamDetailsTableView: TeamDetailsProtocol) {
        self.selectedTeam = selectedTeam
        self.sportName = sportName
        self.teamDetailsTableView = teamDetailsTableView
    }
    
    func getTeamDetails(){
        teamDetailsTableView.displayTeamDetails(res: selectedTeam, sportName: sportName)
    }
    
}
