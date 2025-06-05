//
//  AllSportsPresenter.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 30/05/2025.
//

import Foundation


class AllSportsPresenter {
    var allSportsViewController: AllSportsProtocol!
    var sportsCat: [AllSportsModel]!

    init(allSportsViewController: AllSportsProtocol!) {
        self.allSportsViewController = allSportsViewController
        
        // Create the list of 4 sports
        self.sportsCat = [
                AllSportsModel(name: NSLocalizedString("Football", comment: "Football sport name"), img: "Football"),
                AllSportsModel(name: NSLocalizedString("Basketball", comment: "Basketball sport name"), img: "Basketball"),
                AllSportsModel(name: NSLocalizedString("Tennis", comment: "Tennis sport name"), img: "Tennis"),
                AllSportsModel(name: NSLocalizedString("Cricket", comment: "Cricket sport name"), img: "Cricket")
            ]
    }

    func sendAllSportsCategories() {
        allSportsViewController.displaySports(sports: sportsCat)
    }
}
