//
//  TeamDetailsPresenter.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 01/06/2025.
//

import Foundation

class TeamDetailsPresenter {
    var selectedTeam :TeamModel
    var teamDetailsTableView :TeamDetailsProtocol
    
    init(selectedTeam: TeamModel, teamDetailsTableView: TeamDetailsProtocol) {
        self.selectedTeam = selectedTeam
        self.teamDetailsTableView = teamDetailsTableView
    }
    
    func getTeamDetails(){
        teamDetailsTableView.displayTeamDetails(res: selectedTeam)
    }
    
}
